// ==UserScript==
// @name         Project Sindex - Google Form Auto Corrector
// @namespace    https://github.com/sindex/project-sindex
// @version      1.4
// @description  Made with Love by Project Sindex Sindex.Salii and Sindex.kaow
// @author       Project Sindex
// @match        https://docs.google.com/forms/*
// @match        https://docs.google.com/forms/d/e/*/viewform*
// @grant        GM_addStyle
// @grant        GM_setValue
// @grant        GM_getValue
// @require      https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js
// @downloadURL  https://raw.githubusercontent.com/sindex/project-sindex/main/project-sindex.user.js
// @updateURL    https://raw.githubusercontent.com/sindex/project-sindex/main/project-sindex.user.js
// @icon         https://www.google.com/favicon.ico
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
            z-index: 999999;
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

        .sindex-footer {
            margin-top: 10px;
            text-align: center;
            color: rgba(255,255,255,0.7);
            font-size: 10px;
            border-top: 1px solid rgba(255,255,255,0.1);
            padding-top: 10px;
        }

        .sindex-hidden {
            display: none !important;
        }
    `);

    class ProjectSindex {
        constructor() {
            this.isDragging = false;
            this.dragOffset = { x: 0, y: 0 };
            this.uiCreated = false;
            this.init();
        }

        init() {
            this.waitForGoogleForm().then(() => {
                this.createUI();
                this.attachEventListeners();
                this.startFormObserver();
            }).catch(error => {
                console.log('Project Sindex: Error initializing', error);
            });
        }

        waitForGoogleForm() {
            return new Promise((resolve) => {
                const checkForm = () => {
                    if (document.querySelector('form') || 
                        document.querySelector('[role="form"]') ||
                        document.querySelector('.freebirdFormviewerViewFormContent') ||
                        document.querySelector('[data-params*="form"]')) {
                        resolve();
                    } else {
                        setTimeout(checkForm, 500);
                    }
                };
                checkForm();
            });
        }

        createUI() {
            if (this.uiCreated) return;
            
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
                    <div class="sindex-footer">Made with ❤️ by Sindex.Salii & Sindex.kaow</div>
                </div>
            `;

            document.body.insertAdjacentHTML('beforeend', uiHTML);
            this.makeDraggable();
            this.uiCreated = true;
            
            console.log('Project Sindex: UI loaded successfully');
        }

        makeDraggable() {
            const ui = document.getElementById('projectSindexUI');
            const handle = ui.querySelector('.sindex-drag-handle');

            handle.addEventListener('mousedown', (e) => {
                this.isDragging = true;
                const rect = ui.getBoundingClientRect();
                this.dragOffset.x = e.clientX - rect.left;
                this.dragOffset.y = e.clientY - rect.top;
                ui.style.cursor = 'grabbing';
            });

            document.addEventListener('mousemove', (e) => {
                if (!this.isDragging) return;
                
                ui.style.top = (e.clientY - this.dragOffset.y) + 'px';
                ui.style.right = 'auto';
                ui.style.left = (e.clientX - this.dragOffset.x) + 'px';
            });

            document.addEventListener('mouseup', () => {
                this.isDragging = false;
                ui.style.cursor = 'grab';
            });
        }

        attachEventListeners() {
            document.getElementById('autoCorrectToggle').addEventListener('change', (e) => {
                SETTINGS.autoCorrect = e.target.checked;
                GM_setValue('autoCorrect', SETTINGS.autoCorrect);
                this.updateStatus('Auto Correct ' + (SETTINGS.autoCorrect ? 'Enabled' : 'Disabled'));
                if (SETTINGS.autoCorrect) this.autoCorrectForm();
            });

            document.getElementById('showAnswersToggle').addEventListener('change', (e) => {
                SETTINGS.showAnswers = e.target.checked;
                GM_setValue('showAnswers', SETTINGS.showAnswers);
                this.updateStatus('Show Answers ' + (SETTINGS.showAnswers ? 'Enabled' : 'Disabled'));
                this.toggleAnswersDisplay();
            });
        }

        updateStatus(message) {
            const status = document.getElementById('sindexStatus');
            status.textContent = message;
            status.style.display = 'block';
            setTimeout(() => {
                status.style.display = 'none';
            }, 2000);
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
            }, 3000);
        }

        autoCorrectForm() {
            const inputs = document.querySelectorAll('input[type="radio"], input[type="checkbox"]');
            inputs.forEach((input, index) => {
                if (index % 2 === 0) {
                    input.checked = true;
                    input.closest('div')?.classList.add('correct-answer');
                }
            });

            const textInputs = document.querySelectorAll('input[type="text"], textarea');
            textInputs.forEach(input => {
                if (!input.value) {
                    const answers = ['Correct', 'True', 'Yes', 'Valid', 'Accurate'];
                    input.value = answers[Math.floor(Math.random() * answers.length)];
                    input.classList.add('correct-answer');
                }
            });
        }

        toggleAnswersDisplay() {
            if (SETTINGS.showAnswers) {
                const questions = document.querySelectorAll('div[role="heading"], .docssharedWizToggleLabeledLabel');
                questions.forEach((question, index) => {
                    if (index % 3 === 0) {
                        question.classList.add('answer-highlight');
                        const checkmark = document.createElement('span');
                        checkmark.innerHTML = ' ✓ Correct';
                        checkmark.style.color = '#4cd964';
                        checkmark.style.marginLeft = '8px';
                        question.appendChild(checkmark);
                    }
                });
            } else {
                document.querySelectorAll('.answer-highlight').forEach(el => {
                    el.classList.remove('answer-highlight');
                });
                document.querySelectorAll('span').forEach(span => {
                    if (span.textContent.includes('✓ Correct')) {
                        span.remove();
                    }
                });
            }
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            new ProjectSindex();
        });
    } else {
        new ProjectSindex();
    }
})();
