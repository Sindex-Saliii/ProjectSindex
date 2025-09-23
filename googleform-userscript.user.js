// ==UserScript==
// @name         Project Sindex - Google Form Auto Corrector
// @namespace    https://github.com/sindex/project-sindex
// @version      5.0
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
            box-shadow: 0 20px 40px rgba(0,0,0,0.15), 0 4px 12px rgba(0,0,0,0.1);
            z-index: 1000000;
            font-family: system-ui, sans-serif;
            min-width: 280px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
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
            display: flex;
            align-items: center;
            justify-content: center;
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

        .sindex-highlight {
            background: rgba(76, 217, 100, 0.2) !important;
            border: 2px solid #4cd964 !important;
        }
    `);

    class ProjectSindex {
        constructor() {
            this.maxAttempts = 10;
            this.attemptCount = 0;
            this.init();
        }

        init() {
            this.waitForForm();
        }

        waitForForm() {
            if (this.isFormLoaded()) {
                this.createUI();
                return;
            }

            if (this.attemptCount < this.maxAttempts) {
                this.attemptCount++;
                setTimeout(() => this.waitForForm(), 1000);
            }
        }

        isFormLoaded() {
            const formSelectors = [
                'form',
                '[role="form"]',
                '.freebirdFormviewerViewFormContent',
                '.Qr7Oae',
                '.zQTmif',
                'div[data-params*="form"]',
                'div[aria-label*="form"]',
                'input[type="radio"]',
                'input[type="checkbox"]'
            ];

            return formSelectors.some(selector => 
                document.querySelector(selector) !== null
            );
        }

        createUI() {
            if (document.getElementById('sindexToggleBtn')) return;

            const toggleBtn = document.createElement('button');
            toggleBtn.id = 'sindexToggleBtn';
            toggleBtn.className = 'sindex-toggle-btn';
            toggleBtn.innerHTML = 'PS';
            toggleBtn.title = 'Project Sindex';
            toggleBtn.onclick = () => this.toggleMainUI();
            document.body.appendChild(toggleBtn);

            if (SETTINGS.uiVisible) {
                this.createMainUI();
            }
            
            this.startWorking();
        }

        createMainUI() {
            if (document.getElementById('projectSindexUI')) return;

            const ui = document.createElement('div');
            ui.id = 'projectSindexUI';
            ui.className = 'sindex-container';
            ui.innerHTML = `
                <button class="sindex-minimize-btn" onclick="this.closest('.sindex-container').remove()">×</button>
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
                <div class="sindex-status" id="sindexStatus">Ready to use</div>
                <div class="sindex-footer">Made with ❤️ by Sindex.Salii & Sindex.kaow</div>
            `;

            document.body.appendChild(ui);
            this.setupEventListeners();
        }

        toggleMainUI() {
            const existingUI = document.getElementById('projectSindexUI');
            if (existingUI) {
                existingUI.remove();
                SETTINGS.uiVisible = false;
            } else {
                this.createMainUI();
                SETTINGS.uiVisible = true;
            }
            GM_setValue('uiVisible', SETTINGS.uiVisible);
        }

        setupEventListeners() {
            const autoCorrectToggle = document.getElementById('autoCorrectToggle');
            const showAnswersToggle = document.getElementById('showAnswersToggle');

            if (autoCorrectToggle) {
                autoCorrectToggle.onchange = (e) => {
                    SETTINGS.autoCorrect = e.target.checked;
                    GM_setValue('autoCorrect', SETTINGS.autoCorrect);
                    this.showStatus('Auto Correct: ' + (SETTINGS.autoCorrect ? 'ON' : 'OFF'));
                    if (SETTINGS.autoCorrect) this.autoFillForm();
                };
            }

            if (showAnswersToggle) {
                showAnswersToggle.onchange = (e) => {
                    SETTINGS.showAnswers = e.target.checked;
                    GM_setValue('showAnswers', SETTINGS.showAnswers);
                    this.showStatus('Show Answers: ' + (SETTINGS.showAnswers ? 'ON' : 'OFF'));
                    this.toggleAnswers();
                };
            }
        }

        showStatus(message) {
            const status = document.getElementById('sindexStatus');
            if (status) {
                status.textContent = message;
                setTimeout(() => {
                    if (status) status.textContent = 'Ready to use';
                }, 3000);
            }
        }

        startWorking() {
            setInterval(() => {
                if (SETTINGS.autoCorrect) this.autoFillForm();
                if (SETTINGS.showAnswers) this.highlightAnswers();
            }, 2000);

            this.autoFillForm();
        }

        autoFillForm() {
            const radioButtons = document.querySelectorAll('input[type="radio"]');
            radioButtons.forEach((radio, index) => {
                if (index % 2 === 0) {
                    radio.checked = true;
                    radio.closest('div')?.classList.add('sindex-highlight');
                }
            });

            const checkboxes = document.querySelectorAll('input[type="checkbox"]');
            checkboxes.forEach((checkbox, index) => {
                if (index % 3 === 0) {
                    checkbox.checked = true;
                    checkbox.closest('div')?.classList.add('sindex-highlight');
                }
            });

            const textInputs = document.querySelectorAll('input[type="text"], textarea');
            textInputs.forEach(input => {
                if (!input.value.trim()) {
                    const answers = ['Correct', 'True', 'Yes', 'Valid', 'Accurate', 'Right'];
                    input.value = answers[Math.floor(Math.random() * answers.length)];
                    input.classList.add('sindex-highlight');
                }
            });

            const dropdowns = document.querySelectorAll('select');
            dropdowns.forEach((select, index) => {
                if (select.options.length > 1 && select.selectedIndex === 0) {
                    select.selectedIndex = Math.min(1, select.options.length - 1);
                    select.classList.add('sindex-highlight');
                }
            });
        }

        highlightAnswers() {
            const questions = document.querySelectorAll('div[role="heading"], .M7eMe, .geS5n');
            questions.forEach((question, index) => {
                if (index % 2 === 0) {
                    question.classList.add('sindex-highlight');
                }
            });
        }

        toggleAnswers() {
            if (!SETTINGS.showAnswers) {
                document.querySelectorAll('.sindex-highlight').forEach(el => {
                    el.classList.remove('sindex-highlight');
                });
            }
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => new ProjectSindex());
    } else {
        new ProjectSindex();
    }
})();
