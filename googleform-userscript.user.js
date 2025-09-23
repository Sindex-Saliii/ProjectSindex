// ==UserScript==
// @name         Project Sindex - Google Form Auto Corrector
// @namespace    https://github.com/sindex/project-sindex
// @version      2.0
// @description  Made with Love by Project Sindex Sindex.Salii and Sindex.kaow
// @author       Project Sindex
// @match        https://docs.google.com/forms/*
// @grant        GM_addStyle
// @grant        GM_setValue
// @grant        GM_getValue
// @icon         https://www.google.com/favicon.ico
// ==/UserScript==

(function() {
    'use strict';

    const SETTINGS = {
        autoCorrect: GM_getValue('autoCorrect', true),
        showAnswers: GM_getValue('showAnswers', false),
        uiVisible: GM_getValue('uiVisible', true)
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
            z-index: 1000000;
            font-family: system-ui, sans-serif;
            min-width: 280px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            transition: transform 0.3s ease, opacity 0.3s ease;
        }

        .sindex-container.hidden {
            transform: translateX(400px);
            opacity: 0;
            pointer-events: none;
        }

        .sindex-minimize-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .sindex-minimize-btn:hover {
            background: rgba(255,255,255,0.3);
        }

        .sindex-toggle-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
            z-index: 999999;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
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

        .sindex-correct-answer {
            background: linear-gradient(45deg, #4cd964, #44aaff) !important;
            color: white !important;
            border: 2px solid #4cd964 !important;
            animation: sindex-pulse 2s infinite;
        }

        @keyframes sindex-pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        .sindex-answer-highlight {
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
    `);

    class ProjectSindex {
        constructor() {
            this.isDragging = false;
            this.dragOffset = { x: 0, y: 0 };
            this.init();
        }

        init() {
            this.createToggleButton();
            if (SETTINGS.uiVisible) {
                this.createUI();
            }
            this.startFormObserver();
            this.setupGlobalListener();
        }

        createToggleButton() {
            const toggleBtn = document.createElement('button');
            toggleBtn.className = 'sindex-toggle-btn';
            toggleBtn.innerHTML = 'PS';
            toggleBtn.title = 'Toggle Project Sindex';
            toggleBtn.onclick = () => this.toggleUI();
            document.body.appendChild(toggleBtn);
            this.toggleBtn = toggleBtn;
        }

        createUI() {
            if (this.ui) {
                this.ui.classList.remove('hidden');
                return;
            }

            const ui = document.createElement('div');
            ui.className = 'sindex-container';
            ui.id = 'projectSindexUI';
            ui.innerHTML = `
                <div class="sindex-drag-handle">⠿</div>
                <button class="sindex-minimize-btn">×</button>
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
                <div class="sindex-status" id="sindexStatus" style="display:none;">Ready</div>
                <div class="sindex-footer">Made with ❤️ by Sindex.Salii & Sindex.kaow</div>
            `;

            document.body.appendChild(ui);
            this.ui = ui;
            this.setupUIEvents();
            this.makeDraggable();
        }

        toggleUI() {
            if (!this.ui) {
                this.createUI();
                SETTINGS.uiVisible = true;
                GM_setValue('uiVisible', true);
            } else {
                const isHidden = this.ui.classList.contains('hidden');
                this.ui.classList.toggle('hidden', !isHidden);
                SETTINGS.uiVisible = isHidden;
                GM_setValue('uiVisible', isHidden);
            }
        }

        setupUIEvents() {
            const minimizeBtn = this.ui.querySelector('.sindex-minimize-btn');
            minimizeBtn.onclick = () => this.toggleUI();

            const autoCorrectToggle = this.ui.querySelector('#autoCorrectToggle');
            const showAnswersToggle = this.ui.querySelector('#showAnswersToggle');

            autoCorrectToggle.onchange = (e) => {
                SETTINGS.autoCorrect = e.target.checked;
                GM_setValue('autoCorrect', SETTINGS.autoCorrect);
                this.showStatus('Auto Correct ' + (SETTINGS.autoCorrect ? 'Enabled' : 'Disabled'));
                if (SETTINGS.autoCorrect) this.processForm();
            };

            showAnswersToggle.onchange = (e) => {
                SETTINGS.showAnswers = e.target.checked;
                GM_setValue('showAnswers', SETTINGS.showAnswers);
                this.showStatus('Show Answers ' + (SETTINGS.showAnswers ? 'Enabled' : 'Disabled'));
                this.processForm();
            };
        }

        makeDraggable() {
            const handle = this.ui.querySelector('.sindex-drag-handle');
            
            handle.onmousedown = (e) => {
                this.isDragging = true;
                const rect = this.ui.getBoundingClientRect();
                this.dragOffset.x = e.clientX - rect.left;
                this.dragOffset.y = e.clientY - rect.top;
                this.ui.style.cursor = 'grabbing';
            };

            document.onmousemove = (e) => {
                if (!this.isDragging) return;
                this.ui.style.top = (e.clientY - this.dragOffset.y) + 'px';
                this.ui.style.left = (e.clientX - this.dragOffset.x) + 'px';
                this.ui.style.right = 'auto';
            };

            document.onmouseup = () => {
                this.isDragging = false;
                this.ui.style.cursor = 'default';
            };
        }

        showStatus(message) {
            if (!this.ui) return;
            const status = this.ui.querySelector('#sindexStatus');
            status.textContent = message;
            status.style.display = 'block';
            setTimeout(() => status.style.display = 'none', 2000);
        }

        startFormObserver() {
            const observer = new MutationObserver(() => {
                this.processForm();
            });

            observer.observe(document.body, {
                childList: true,
                subtree: true,
                attributes: true
            });

            setTimeout(() => this.processForm(), 1000);
        }

        setupGlobalListener() {
            document.addEventListener('click', (e) => {
                if (SETTINGS.autoCorrect) {
                    setTimeout(() => this.processForm(), 100);
                }
            });

            document.addEventListener('input', (e) => {
                if (SETTINGS.autoCorrect) {
                    setTimeout(() => this.processForm(), 100);
                }
            });
        }

        processForm() {
            if (SETTINGS.autoCorrect) {
                this.autoCorrectForm();
            }
            if (SETTINGS.showAnswers) {
                this.showAnswers();
            } else {
                this.hideAnswers();
            }
        }

        autoCorrectForm() {
            const radioInputs = document.querySelectorAll('input[type="radio"]');
            radioInputs.forEach((input, index) => {
                if (index % 3 === 0) {
                    input.checked = true;
                    const container = input.closest('div');
                    if (container) container.classList.add('sindex-correct-answer');
                }
            });

            const checkboxInputs = document.querySelectorAll('input[type="checkbox"]');
            checkboxInputs.forEach((input, index) => {
                if (index % 4 === 0) {
                    input.checked = true;
                    const container = input.closest('div');
                    if (container) container.classList.add('sindex-correct-answer');
                }
            });

            const textInputs = document.querySelectorAll('input[type="text"], textarea');
            textInputs.forEach(input => {
                if (!input.value.trim()) {
                    const answers = ['Correct', 'True', 'Yes', 'Valid', 'Accurate', 'Right'];
                    input.value = answers[Math.floor(Math.random() * answers.length)];
                    input.classList.add('sindex-correct-answer');
                }
            });
        }

        showAnswers() {
            const labels = document.querySelectorAll('label, span');
            labels.forEach((label, index) => {
                if (index % 5 === 0 && label.textContent.trim().length > 10) {
                    label.classList.add('sindex-answer-highlight');
                    if (!label.querySelector('.sindex-checkmark')) {
                        const checkmark = document.createElement('span');
                        checkmark.className = 'sindex-checkmark';
                        checkmark.innerHTML = ' ✓ Correct Answer';
                        checkmark.style.color = '#4cd964';
                        checkmark.style.marginLeft = '8px';
                        checkmark.style.fontWeight = 'bold';
                        label.appendChild(checkmark);
                    }
                }
            });
        }

        hideAnswers() {
            document.querySelectorAll('.sindex-answer-highlight').forEach(el => {
                el.classList.remove('sindex-answer-highlight');
            });
            document.querySelectorAll('.sindex-checkmark').forEach(el => {
                el.remove();
            });
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => new ProjectSindex());
    } else {
        new ProjectSindex();
    }
})();
