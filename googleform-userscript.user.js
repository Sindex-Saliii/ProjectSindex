// ==UserScript==
// @name         Project Sindex - Google Form Auto Corrector (Revised)
// @namespace    https://github.com/sindex/project-sindex
// @version      6.0.1
// @description  Made with Love by Project Sindex Sindex.Salii and Sindex.kaow - Revised for stability
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
            border: 1px solid rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease-in-out;
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
            background: linear-gradient(45deg, #4cd964, #44aaff) !important;
            color: white !important;
            border: 2px solid #4cd964 !important;
            border-radius: 4px !important;
            padding: 8px 12px !important;
            margin: 4px 0 !important;
        }

        .sindex-correct-answer {
            background: rgba(76, 217, 100, 0.15) !important;
            border-left: 4px solid #4cd964 !important;
            padding: 10px !important;
            margin: 5px 0 !important;
            border-radius: 4px !important;
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
                setTimeout(() => this.createMainUI(), 500);
            }
            // ใช้ MutationObserver เพื่อตรวจสอบการเปลี่ยนแปลงของฟอร์มอย่างมีประสิทธิภาพ
            this.setupMutationObserver();
            this.processForm();
        }

        setupMutationObserver() {
            const observer = new MutationObserver(() => this.processForm());
            const formContainer = document.querySelector('form');
            if (formContainer) {
                observer.observe(formContainer, { childList: true, subtree: true });
            } else {
                // สำหรับกรณีที่ฟอร์มโหลดช้า ให้ลองตรวจสอบซ้ำ
                setTimeout(() => {
                    const formContainerRetry = document.querySelector('form');
                    if (formContainerRetry) {
                        observer.observe(formContainerRetry, { childList: true, subtree: true });
                    }
                }, 1000);
            }
        }

        createToggleButton() {
            if (document.getElementById('sindexToggleBtn')) return;
            
            const toggleBtn = document.createElement('button');
            toggleBtn.id = 'sindexToggleBtn';
            toggleBtn.className = 'sindex-toggle-btn';
            toggleBtn.innerHTML = 'PS';
            toggleBtn.title = 'Project Sindex - Click to open';
            toggleBtn.onclick = () => this.toggleMainUI();
            document.body.appendChild(toggleBtn);
        }

        createMainUI() {
            if (document.getElementById('projectSindexUI')) return;

            const ui = document.createElement('div');
            ui.id = 'projectSindexUI';
            ui.className = 'sindex-container';
            ui.style.display = SETTINGS.uiVisible ? 'block' : 'none'; // ใช้ค่าเริ่มต้น
            ui.innerHTML = `
                <button class="sindex-close-btn" id="sindexCloseBtn">×</button>
                <div class="sindex-header">
                    <div class="sindex-logo">PS</div>
                    <h3 class="sindex-title">Project Sindex</h3>
                </div>
                <div class="sindex-toggle-group">
                    <div class="sindex-toggle">
                        <span class="sindex-label">Auto Correct (Guess)</span>
                        <label class="sindex-switch">
                            <input type="checkbox" id="autoCorrectToggle" ${SETTINGS.autoCorrect ? 'checked' : ''}>
                            <span class="sindex-slider"></span>
                        </label>
                    </div>
                    <div class="sindex-toggle">
                        <span class="sindex-label">Show Answers (Fake)</span>
                        <label class="sindex-switch">
                            <input type="checkbox" id="showAnswersToggle" ${SETTINGS.showAnswers ? 'checked' : ''}>
                            <span class="sindex-slider"></span>
                        </label>
                    </div>
                </div>
                <div class="sindex-status" id="sindexStatus">✅ Ready to use</div>
                <div class="sindex-footer">Made with ❤️ by Sindex.Salii & Sindex.kaow</div>
            `;

            document.body.appendChild(ui);
            this.setupEventListeners();
        }

        toggleMainUI() {
            const ui = document.getElementById('projectSindexUI');
            if (ui) {
                const isVisible = ui.style.display !== 'block';
                ui.style.display = isVisible ? 'block' : 'none';
                SETTINGS.uiVisible = isVisible;
            } else {
                this.createMainUI();
                SETTINGS.uiVisible = true;
            }
            GM_setValue('uiVisible', SETTINGS.uiVisible);
        }

        setupEventListeners() {
            const ui = document.getElementById('projectSindexUI');
            if (!ui) return;

            const closeBtn = document.getElementById('sindexCloseBtn');
            if (closeBtn) {
                closeBtn.onclick = () => {
                    ui.style.display = 'none';
                    SETTINGS.uiVisible = false;
                    GM_setValue('uiVisible', SETTINGS.uiVisible);
                };
            }

            const autoCorrectToggle = document.getElementById('autoCorrectToggle');
            const showAnswersToggle = document.getElementById('showAnswersToggle');

            if (autoCorrectToggle) {
                autoCorrectToggle.onchange = (e) => {
                    SETTINGS.autoCorrect = e.target.checked;
                    GM_setValue('autoCorrect', SETTINGS.autoCorrect);
                    this.updateStatus(`Auto Correct: ${SETTINGS.autoCorrect ? 'ON' : 'OFF'}`);
                    this.processForm();
                };
            }

            if (showAnswersToggle) {
                showAnswersToggle.onchange = (e) => {
                    SETTINGS.showAnswers = e.target.checked;
                    GM_setValue('showAnswers', SETTINGS.showAnswers);
                    this.updateStatus(`Show Answers: ${SETTINGS.showAnswers ? 'ON' : 'OFF'}`);
                    this.processForm();
                };
            }
        }

        updateStatus(message) {
            const status = document.getElementById('sindexStatus');
            if (status) {
                status.textContent = message;
                setTimeout(() => {
                    if (status) status.textContent = '✅ Ready to use';
                }, 3000);
            }
        }

        processForm() {
            this.hideCorrectAnswers(); // ล้างของเดิมก่อนเสมอ
            
            if (SETTINGS.autoCorrect) {
                this.autoCorrectAnswers();
            }
            if (SETTINGS.showAnswers) {
                this.showCorrectAnswers();
            }
        }

        // ฟังก์ชันเดาคำตอบ (ไม่ถูกต้อง)
        autoCorrectAnswers() {
            this.markCorrectRadioButtons();
            this.markCorrectCheckboxes();
            this.fillTextInputs();
        }

        // เลือกตัวเลือกแรกสุดในแต่ละกลุ่ม (การเดา)
        markCorrectRadioButtons() {
            try {
                const radios = document.querySelectorAll('input[type="radio"]:not([checked])');
                const groups = this.groupRadioButtons(radios);
                
                groups.forEach(group => {
                    // เลือกตัวเลือกแรกสุดในกลุ่ม
                    if (group.length > 0) {
                        const firstRadio = group[0];
                        if (!firstRadio.checked) {
                            firstRadio.checked = true;
                            // จำลองการคลิกเพื่อเรียกใช้ Event ของ Google Forms
                            firstRadio.dispatchEvent(new Event('click', { bubbles: true }));
                            firstRadio.dispatchEvent(new Event('change', { bubbles: true }));
                        }
                        this.highlightElement(firstRadio, true);
                    }
                });
            } catch (e) { console.error('Error in markCorrectRadioButtons:', e); }
        }

        // เลือก Checkbox ที่เป็นลำดับคู่ (การเดา)
        markCorrectCheckboxes() {
            try {
                const checkboxes = document.querySelectorAll('input[type="checkbox"]:not([checked])');
                checkboxes.forEach((checkbox, index) => {
                    // ใช้ index ของ checkbox ที่ยังไม่ถูกเลือกในหน้านั้นเป็นหลัก
                    if (index % 2 === 0) {
                        if (!checkbox.checked) {
                            checkbox.checked = true;
                            // จำลองการคลิกเพื่อเรียกใช้ Event ของ Google Forms
                            checkbox.dispatchEvent(new Event('click', { bubbles: true }));
                            checkbox.dispatchEvent(new Event('change', { bubbles: true }));
                        }
                        this.highlightElement(checkbox, true);
                    }
                });
            } catch (e) { console.error('Error in markCorrectCheckboxes:', e); }
        }

        // กรอกข้อความสุ่ม (การเดา)
        fillTextInputs() {
            try {
                const textInputs = document.querySelectorAll('input[type="text"], textarea');
                const answers = ['Correct', 'True', 'Yes', 'Valid', 'Accurate', 'Right', 'ถูกต้อง'];
                textInputs.forEach(input => {
                    if (!input.value || input.value.trim() === '') {
                        input.value = answers[Math.floor(Math.random() * answers.length)];
                        // จำลองการพิมพ์เพื่อเรียกใช้ Event ของ Google Forms
                        input.dispatchEvent(new Event('input', { bubbles: true }));
                        input.dispatchEvent(new Event('change', { bubbles: true }));
                        this.highlightElement(input, true);
                    }
                });
            } catch (e) { console.error('Error in fillTextInputs:', e); }
        }

        groupRadioButtons(radios) {
            const groups = {};
            radios.forEach(radio => {
                const name = radio.getAttribute('name') || radio.closest('[role="listitem"]')?.id || 'default_group';
                if (!groups[name]) groups[name] = [];
                groups[name].push(radio);
            });
            return Object.values(groups);
        }

        // ฟังก์ชันแสดงคำตอบ (ไม่ถูกต้อง)
        showCorrectAnswers() {
            try {
                // พยายามหาตัวเลือกที่คล้ายกันโดยไม่ต้องใช้ class name ที่เปลี่ยนบ่อย
                const optionContainers = document.querySelectorAll('[role="radio"], [role="checkbox"]');
                
                optionContainers.forEach((option, index) => {
                    // ใช้หลักการเดา: ไฮไลต์ตัวเลือกที่เป็นลำดับคู่
                    if (index % 2 === 0) {
                        this.highlightElement(option, false);
                        this.addCheckmark(option);
                    }
                });
            } catch (e) { console.error('Error in showCorrectAnswers:', e); }
        }

        hideCorrectAnswers() {
            document.querySelectorAll('.sindex-correct, .sindex-correct-answer').forEach(el => {
                el.classList.remove('sindex-correct', 'sindex-correct-answer');
                // ลบสไตล์อินไลน์ที่อาจเพิ่มเข้ามาจากการไฮไลต์
                if (el.style.length !== 0) {
                    el.removeAttribute('style');
                }
            });
            
            document.querySelectorAll('.sindex-checkmark').forEach(el => {
                el.remove();
            });
        }

        highlightElement(element, isInput) {
            let container = element;
            if (isInput) {
                // สำหรับ input, radio, checkbox ให้หา container ที่ใหญ่ขึ้น
                container = element.closest('.freebirdFormviewerComponentsQuestionRadioOption, .freebirdFormviewerComponentsQuestionCheckboxOption') || element.closest('.quantumWizMenuPaperselectOption') || element;
            } else {
                // สำหรับการแสดงคำตอบ ให้หา container ของตัวเลือก
                container = element.closest('.freebirdFormviewerComponentsQuestionRadioOption, .freebirdFormviewerComponentsQuestionCheckboxOption') || element;
            }
            
            if (isInput) {
                container.classList.add('sindex-correct');
            } else {
                container.classList.add('sindex-correct-answer');
            }
        }

        addCheckmark(element) {
            const optionTextElement = element.querySelector('.docssharedWizToggleLabeledLabelText');
            const targetElement = optionTextElement || element;

            if (!targetElement.querySelector('.sindex-checkmark')) {
                const checkmark = document.createElement('span');
                checkmark.className = 'sindex-checkmark';
                checkmark.textContent = ' ✓ Correct';
                targetElement.appendChild(checkmark);
            }
        }
    }

    new ProjectSindex();
})();
