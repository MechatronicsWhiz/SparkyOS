import os
import sys
import subprocess
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit, QPushButton, QFileDialog, QMessageBox, QCheckBox
from PyQt5.QtGui import QIcon
from PyQt5.QtCore import QProcess
from styles import stylesheet 

class DesktopFileCreator(QWidget):
    def __init__(self):
        super().__init__()
        self.setStyleSheet(stylesheet) 
        self.initUI()
        self.process = None  # Initialize QProcess instance

    def initUI(self):
        self.setWindowTitle('App Builder')
        self.setWindowIcon(QIcon('app_builder_icon.png'))  
        self.setGeometry(200, 25, 400, 250)

        layout = QVBoxLayout()

        self.name_label = QLabel('Application Name:')
        self.name_edit = QLineEdit()
        layout.addWidget(self.name_label)
        layout.addWidget(self.name_edit)

        self.icon_label = QLabel('App Icon:')
        self.icon_edit = QLineEdit()
        self.icon_button = QPushButton('Browse')
        self.icon_button.clicked.connect(self.selectIconFile)
        icon_layout = QHBoxLayout()
        icon_layout.addWidget(self.icon_edit)
        icon_layout.addWidget(self.icon_button)
        layout.addWidget(self.icon_label)
        layout.addLayout(icon_layout)

        self.script_label = QLabel('Python Script File:')
        self.script_edit = QLineEdit()
        self.script_button = QPushButton('Browse')
        self.script_button.clicked.connect(self.selectScriptFile)
        script_layout = QHBoxLayout()
        script_layout.addWidget(self.script_edit)
        script_layout.addWidget(self.script_button)
        layout.addWidget(self.script_label)
        layout.addLayout(script_layout)

        self.add_to_panel_checkbox = QCheckBox('Add App to Panel?')
        layout.addWidget(self.add_to_panel_checkbox)

        self.create_button = QPushButton('Create App')
        self.create_button.clicked.connect(self.createDesktopFile)
        layout.addWidget(self.create_button)

        self.setLayout(layout)

    def selectIconFile(self):
        file_dialog = QFileDialog()
        file_dialog.setFileMode(QFileDialog.ExistingFile)
        file_dialog.setNameFilter('Icon files (*.png *.ico *.svg)')
        if file_dialog.exec_():
            file_path = file_dialog.selectedFiles()[0]
            self.icon_edit.setText(file_path)

    def selectScriptFile(self):
        file_dialog = QFileDialog()
        file_dialog.setFileMode(QFileDialog.ExistingFile)
        file_dialog.setNameFilter('Python scripts (*.py)')
        if file_dialog.exec_():
            file_path = file_dialog.selectedFiles()[0]
            self.script_edit.setText(file_path)

    def createDesktopFile(self):
        app_name = self.name_edit.text()
        icon_file = self.icon_edit.text()
        script_file = self.script_edit.text()
        add_to_panel = self.add_to_panel_checkbox.isChecked()

        if not (app_name and icon_file and script_file):
            QMessageBox.warning(self, 'Warning', 'Please fill all fields.')
            return

        desktop_file_content = f'''[Desktop Entry]
                                Version=1.0
                                Type=Application
                                Name={app_name}
                                Exec=python3 "{script_file}"
                                Icon={icon_file}
                                Terminal=false
                                Categories=Utility;'''  # Customize Categories as needed

        # Determine the directory of the selected Python script
        script_directory = os.path.dirname(script_file)
        desktop_file_path = os.path.join(script_directory, f"{app_name.replace(' ', '')}.desktop")

        try:
            with open(desktop_file_path, 'w') as desktop_file:
                desktop_file.write(desktop_file_content)
            QMessageBox.information(self, 'Success', f'App created: {desktop_file_path}')

            if add_to_panel:
                # Call function to add shortcut to LXQt panel
                self.call_add_app_to_panel(desktop_file_path)

        except Exception as e:
            QMessageBox.critical(self, 'Error', f'Failed to create App: {str(e)}')

    def call_add_app_to_panel(self, desktop_file_path):
        # Use QProcess to handle the command asynchronously
        self.process = QProcess()
        self.process.setProcessChannelMode(QProcess.MergedChannels)
        self.process.readyReadStandardOutput.connect(self.handle_output)
        self.process.start('bash', ['-c', f'source /usr/local/bin/functions.sh && add_app_to_panel "{desktop_file_path}"'])

    def handle_output(self):
        output = self.process.readAllStandardOutput().data().decode().strip()
        if output:
            QMessageBox.information(self, 'Success', 'Application added to panel successfully.')

            # Restart LXQt panel
            self.restart_panel()

    def restart_panel(self):
        # Restart LXQt panel by terminating the current instance and starting a new one
        try:
            self.process = QProcess()
            self.process.startDetached('lxqt-panel')
        except Exception as e:
            QMessageBox.critical(self, 'Error', f'Failed to restart panel: {e}')

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = DesktopFileCreator()
    window.show()
    sys.exit(app.exec_())
