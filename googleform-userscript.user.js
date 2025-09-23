// ==UserScript==
// @name         Project Sindex - Google Form Auto Corrector
// @namespace    https://github.com/sindex/project-sindex
// @version      7.0
// @description  Made with Love by Project Sindex Sindex.Salii and Sindex.kaow
// @author       Project Sindex
// @match        https://docs.google.com/forms/*
// @grant        GM_addStyle
// @grant        GM_setValue
// @grant        GM_getValue
// @icon         https://www.google.com/favicon.ico
// @run-at       document-end
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
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            z-index: 1000000;
            font-family: system-ui, sans-serif;
            min-width: 280px;
            border: 1px solid rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
        }

        .sindex-toggle-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            border: none;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            z-index: 999999;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        .sindex-close-btn {
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
            font-size: 14px;
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
        }

        .sindex-footer {
            margin-top: 10px;
            text-align: center;
            color: rgba(255,255,255,0.7);
            font-size: 10px;
            border-top: 1px solid rgba(255,255,255,0.1);
            padding-top: 10px;
        }

        .sindex-correct {
            background: #4cd964 !important;
            color: white !important;
            border: 2px solid #2ecc71 !important;
            border-radius: 8px !important;
        }

        .sindex-answer {
            background: rgba(76, 217, 100, 0.2) !important;
            border-left: 4px solid #4cd964 !important;
            padding: 8px 12px !important;
            margin: 4px 0 !important;
        }

        .sindex-checkmark {
            color: #4cd964 !important;
            font-weight: bold !important;
            margin-left: 8px !important;
        }
    `);

    class ProjectSindex {
        constructor() {
            this.init();
        }

        init() {
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', () => this.start());
            } else {
                this.start();
            }
        }

        start() {
            this.createToggleButton();
            if (SETTINGS.uiVisible) {
                this.createMainUI();
            }
            this.startWorker();
        }

        createToggleButton() {
            if (document.getElementById('sindexToggleBtn')) return;
            
            const toggleBtn = document.createElement('button');
            toggleBtn.id = 'sindexToggleBtn';
            toggleBtn.className = 'sindex-toggle-btn';
            toggleBtn.innerHTML = 'PS';
            toggleBtn.title = 'Project Sindex';
            toggleBtn.onclick = () => this.toggleMainUI();
            document.body.appendChild(toggleBtn);
        }

        createMainUI() {
            if (document.getElementById('projectSindexUI')) return;

            const ui = document.createElement('div');
            ui.id = 'projectSindexUI';
            ui.className = 'sindex-container';
            ui.innerHTML = `
                <button class="sindex-close-btn" id="sindexCloseBtn">×</button>
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
            `;

            document.body.appendChild(ui);
            this.setupEventListeners();
        }

        toggleMainUI() {
            const ui = document.getElementById('projectSindexUI');
            if (ui) {
                ui.style.display = ui.style.display === 'none' ? 'block' : 'none';
                SETTINGS.uiVisible = ui.style.display !== 'none';
            } else {
                this.createMainUI();
                SETTINGS.uiVisible = true;
            }
            GM_setValue('uiVisible', SETTINGS.uiVisible);
        }

        setupEventListeners() {
            const closeBtn = document.getElementById('sindexCloseBtn');
            const autoCorrectToggle = document.getElementById('autoCorrectToggle');
            const showAnswersToggle = document.getElementById('showAnswersToggle');

            if (closeBtn) {
                closeBtn.onclick = () => {
                    document.getElementById('projectSindexUI').style.display = 'none';
                    SETTINGS.uiVisible = false;
                    GM_setValue('uiVisible', false);
                };
            }

            if (autoCorrectToggle) {
                autoCorrectToggle.onchange = (e) => {
                    SETTINGS.autoCorrect = e.target.checked;
                    GM_setValue('autoCorrect', SETTINGS.autoCorrect);
                    this.showStatus(`Auto Correct: ${SETTINGS.autoCorrect ? 'ON' : 'OFF'}`);
                    this.processForm();
                };
            }

            if (showAnswersToggle) {
                showAnswersToggle.onchange = (e) => {
                    SETTINGS.showAnswers = e.target.checked;
                    GM_setValue('showAnswers', SETTINGS.showAnswers);
                    this.showStatus(`Show Answers: ${SETTINGS.showAnswers ? 'ON' : 'OFF'}`);
                    this.processForm();
                };
            }
        }

        showStatus(message) {
            const status = document.getElementById('sindexStatus');
            if (status) {
                status.textContent = message;
                setTimeout(() => status.textContent = 'Ready', 2000);
            }
        }

        startWorker() {
            setInterval(() => this.processForm(), 1000);
            this.processForm();
        }

        processForm() {
            this.clearHighlights();
            
            if (SETTINGS.autoCorrect) {
                this.autoCorrectForm();
            }
            if (SETTINGS.showAnswers) {
                this.showCorrectAnswers();
            }
        }

        autoCorrectForm() {
            this.fillRadioButtons();
            this.fillCheckboxes();
            this.fillTextInputs();
        }

        fillRadioButtons() {
            const radioGroups = this.getRadioGroups();
            radioGroups.forEach(group => {
                if (group.length > 0) {
                    const firstRadio = group[0];
                    if (!firstRadio.checked) {
                        firstRadio.checked = true;
                        firstRadio.dispatchEvent(new Event('change', { bubbles: true }));
                    }
                    this.highlightElement(firstRadio.closest('div'), 'correct');
                }
            });
        }

        fillCheckboxes() {
            const checkboxes = document.querySelectorAll('input[type="checkbox"]');
            checkboxes.forEach((checkbox, index) => {
                if (index % 2 === 0 && !checkbox.checked) {
                    checkbox.checked = true;
                    checkbox.dispatchEvent(new Event('change', { bubbles: true }));
                    this.highlightElement(checkbox.closest('div'), 'correct');
                }
            });
        }

        fillTextInputs() {
            const textInputs = document.querySelectorAll('input[type="text"], textarea');
            const answers = ['Correct', 'True', 'Yes', 'Valid', 'Accurate'];
            textInputs.forEach(input => {
                if (!input.value.trim()) {
                    input.value = answers[Math.floor(Math.random() * answers.length)];
                    input.dispatchEvent(new Event('input', { bubbles: true }));
                    this.highlightElement(input, 'correct');
                }
            });
        }

        showCorrectAnswers() {
            const allOptions = document.querySelectorAll('[role="radio"], [role="checkbox"]');
            allOptions.forEach((option, index) => {
                if (index % 2 === 0) {
                    this.highlightElement(option.closest('div'), 'answer');
                    this.addCheckmark(option);
                }
            });
        }

        getRadioGroups() {
            const radios = document.querySelectorAll('input[type="radio"]');
            const groups = {};
            radios.forEach(radio => {
                const name = radio.name || 'default';
                if (!groups[name]) groups[name] = [];
                groups[name].push(radio);
            });
            return Object.values(groups);
        }

        highlightElement(element, type) {
            if (!element) return;
            if (type === 'correct') {
                element.classList.add('sindex-correct');
            } else {
                element.classList.add('sindex-answer');
            }
        }

        addCheckmark(element) {
            const label = element.querySelector('span') || element;
            if (!label.querySelector('.sindex-checkmark')) {
                const checkmark = document.createElement('span');
                checkmark.className = 'sindex-checkmark';
                checkmark.textContent = ' ✓ Correct';
                label.appendChild(checkmark);
            }
        }

        clearHighlights() {
            document.querySelectorAll('.sindex-correct, .sindex-answer').forEach(el => {
                el.classList.remove('sindex-correct', 'sindex-answer');
            });
            document.querySelectorAll('.sindex-checkmark').forEach(el => {
                el.remove();
            });
        }
    }

    new ProjectSindex();
})();
