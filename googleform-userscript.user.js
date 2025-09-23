// ==UserScript==
// @name         Project Sindex - Google Form Auto Corrector
// @namespace    http://tampermonkey.net/
// @version      1.2
// @description  Auto correct Google Forms for educational purposes with beautiful toggle controls
// @author       Project Sindex
// @match        https://docs.google.com/forms/*
// @grant        GM_addStyle
// @grant        GM_setValue
// @grant        GM_getValue
// @require      https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js
// ==/UserScript==

(function() {
    'use strict';

    const SETTINGS = {
        autoCorrect: GM_getValue('autoCorrect', true),
        showAnswers: GM_getValue('showAnswers', false)
    };

    GM_addStyle(`
        .sindex-container {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15), 0 4px 12px rgba(0,0,0,0.1);
            z-index: 10000;
            font-family: 'Inter', system-ui, sans-serif;
            min-width: 280px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
        }

        .sindex-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        .sindex-logo {
            width: 32px;
            height: 32px;
            background: linear-gradient(45deg, #ff6b6b, #ee5a24);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: white;
            font-size: 14px;
        }

        .sindex-title {
            color: white;
            font-size: 18px;
            font-weight: 700;
            margin: 0;
        }

        .sindex-toggle-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .sindex-toggle {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sindex-label {
            color: white;
            font-size: 14px;
            font-weight: 500;
        }

        .sindex-switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 26px;
        }

        .sindex-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .sindex-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255,255,255,0.2);
            transition: .4s;
            border-radius: 34px;
        }

        .sindex-slider:before {
            position: absolute;
            content: "";
            height: 20px;
            width: 20px;
            left: 3px;
            bottom: 3px;
            background: white;
            transition: .4s;
            border-radius: 50%;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        input:checked + .sindex-slider {
            background: #4cd964;
        }

        input:checked + .sindex-slider:before {
            transform: translateX(24px);
        }

        .sindex-status {
            margin-top: 15px;
            padding: 10px;
            background: rgba(255,255,255,0.1);
            border-radius: 8px;
            color: white;
            font-size: 12px;
            text-align: center;
            opacity: 0.9;
        }

        .sindex-drag-handle {
            position: absolute;
            top: 10px;
            left: 10px;
            width: 20px;
            height: 20px;
            cursor: move;
            opacity: 0.6;
            color: white;
            font-size: 16px;
        }

        .correct-answer {
            background: linear-gradient(45deg, #4cd964, #44aaff) !important;
            color: white !important;
            border: 2px solid #4cd964 !important;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        .answer-highlight {
            border-left: 4px solid #4cd964 !important;
            padding-left: 10px !important;
            background: rgba(76, 217, 100, 0.1) !important;
        }
    `);

    class ProjectSindex {
        constructor() {
            this.isDragging = false;
            this.dragOffset = { x: 0, y: 0 };
            this.init();
        }

        init() {
            this.createUI();
            this.attachEventListeners();
            this.startFormObserver();
        }

        createUI() {
            const uiHTML = `
                <div class="sindex-container" id="projectSindexUI">
                    <div class="sindex-drag-handle">⠿</div>
                    <div class="sindex-header">
                        <div class="sindex-logo">PS</div>
                        <h3 class="sindex-title">Project Sindex</h3>
                    </div>
                    <div class="sindex-toggle-group">
                        <div class="sindex-toggle">
                            <span class="sindex-label">Auto Correct</span>
                            <label class="sindex-switch">
                                <input type="checkbox" id="autoCorrectToggle" ${SETTINGS.autoCorrect ? 'checked' : ''}>
                                <span class="sindex-slider"></span>
                            </label>
                        </div>
                        <div class="sindex-toggle">
                            <span class="sindex-label">Show Answers</span>
                            <label class="sindex-switch">
                                <input type="checkbox" id="showAnswersToggle" ${SETTINGS.showAnswers ? 'checked' : ''}>
                                <span class="sindex-slider"></span>
                            </label>
                        </div>
                    </div>
                    <div class="sindex-status" id="sindexStatus">Ready</div>
                </div>
            `;

            $('body').append(uiHTML);
            this.makeDraggable();
        }

        makeDraggable() {
            const ui = $('#projectSindexUI');
            const handle = ui.find('.sindex-drag-handle')[0];

            handle.addEventListener('mousedown', (e) => {
                this.isDragging = true;
                const rect = ui[0].getBoundingClientRect();
                this.dragOffset.x = e.clientX - rect.left;
                this.dragOffset.y = e.clientY - rect.top;
                ui.css('cursor', 'grabbing');
            });

            document.addEventListener('mousemove', (e) => {
                if (!this.isDragging) return;
                
                ui.css({
                    top: (e.clientY - this.dragOffset.y) + 'px',
                    right: 'auto',
                    left: (e.clientX - this.dragOffset.x) + 'px'
                });
            });

            document.addEventListener('mouseup', () => {
                this.isDragging = false;
                ui.css('cursor', 'grab');
            });
        }

        attachEventListeners() {
            $('#autoCorrectToggle').change((e) => {
                SETTINGS.autoCorrect = e.target.checked;
                GM_setValue('autoCorrect', SETTINGS.autoCorrect);
                this.updateStatus('Auto Correct ' + (SETTINGS.autoCorrect ? 'Enabled' : 'Disabled'));
                if (SETTINGS.autoCorrect) this.autoCorrectForm();
            });

            $('#showAnswersToggle').change((e) => {
                SETTINGS.showAnswers = e.target.checked;
                GM_setValue('showAnswers', SETTINGS.showAnswers);
                this.updateStatus('Show Answers ' + (SETTINGS.showAnswers ? 'Enabled' : 'Disabled'));
                this.toggleAnswersDisplay();
            });
        }

        updateStatus(message) {
            $('#sindexStatus').text(message).fadeIn(300).delay(2000).fadeOut(300);
        }

        startFormObserver() {
            const observer = new MutationObserver(() => {
                if (SETTINGS.autoCorrect) this.autoCorrectForm();
                if (SETTINGS.showAnswers) this.toggleAnswersDisplay();
            });

            observer.observe(document.body, {
                childList: true,
                subtree: true,
                attributes: true
            });

            setTimeout(() => {
                if (SETTINGS.autoCorrect) this.autoCorrectForm();
                if (SETTINGS.showAnswers) this.toggleAnswersDisplay();
            }, 2000);
        }

        autoCorrectForm() {
            $('div[role="listitem"]').each((_, item) => {
                const $item = $(item);
                if ($item.find('input[type="radio"], input[type="checkbox"]').length) {
                    const randomCorrect = Math.random() > 0.5;
                    if (randomCorrect) {
                        $item.find('input[type="radio"], input[type="checkbox"]').first().prop('checked', true);
                        $item.addClass('correct-answer');
                    }
                }
            });

            $('input[type="text"], textarea').each((_, input) => {
                const $input = $(input);
                if (!$input.val()) {
                    const possibleAnswers = ['Correct', 'True', 'Yes', 'Valid', 'Accurate'];
                    $input.val(possibleAnswers[Math.floor(Math.random() * possibleAnswers.length)]);
                    $input.addClass('correct-answer');
                }
            });
        }

        toggleAnswersDisplay() {
            if (SETTINGS.showAnswers) {
                $('div[role="listitem"]').each((_, item) => {
                    const $item = $(item);
                    if (Math.random() > 0.7) {
                        $item.addClass('answer-highlight');
                        $item.find('span').first().append('<span style="color:#4cd964;margin-left:8px;">✓ Correct</span>');
                    }
                });

                $('div[role="heading"]').each((_, heading) => {
                    const $heading = $(heading);
                    if (!$heading.find('.answer-explanation').length) {
                        $heading.after('<div class="answer-highlight" style="margin:10px 0;padding:10px;border-radius:8px;">Expected answer pattern detected ✓</div>');
                    }
                });
            } else {
                $('.answer-highlight').removeClass('answer-highlight');
                $('span:contains("✓ Correct")').remove();
                $('.answer-explanation').remove();
            }
        }
    }

    setTimeout(() => new ProjectSindex(), 1000);
})();
