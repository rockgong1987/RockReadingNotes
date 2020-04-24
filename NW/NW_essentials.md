# NW Essendtials Reading Note
## 1. Meet NW.js
- made by Roger Wang of Intel's Open Source Technology Center(Shanghai office)
- NW : Node.js + WebKit
## 2. NW.js Native UI APIs
### 1. App
    var gui = require('nw.gui');
    var args = gui.App.argv;

    // If arguments are passed
    if (args.length > 0) {
        args.forEach(function(arg) {
            ...
        })
    }
### 
    var gui = require('nw.gui');
    gui.App.on('open', function(cmdLine) {
        console.log('command line : ' + cmdline)
    });
### 
    var gui = require('nw.gui');
    alert(gui.App.dataPath);
### 
    var fs = require('fs'),
      gui = require('nw.gui'),
      path = require('path');
    var settings = {
        'show_sidebar' : true,
        'show_icons' : false
    };
    var settingsFilename = path.join(gui.App.dataPath, 'mySettings.json');
    fs.writeFile(settingsFilename, JSON.stringify(settings));
    fs.readFile(setingsFilename, 'utf8', function(err, data) {
        var savedSettings = JSON.parse(data);
        console.log(savedSettings);
    })
### 
    var gui = require('nw.gui');
    var manifestData = gui.App.manifest;
    alert(manifestData.name);
### 
    gui.App.closeAllWindows();
    this.close(true);
    gui.App.quit();
### 
    var gui = require('nw.gui');
    var shortcut = new gui.Shortcut({
        key : "Ctrl+Alt+A",
        active : function() {
            gui.Window.get().show();
            console.log("You pressed: " + this.key);
        }
    });
    gui.App.registerGlobalHotKey(shortcut);
### 
- Other app APIs
    - App.fullArgv:full list of arguments
    - App.createShortcut(string filePath):(Windows Only)
    - App.clearCache():clear http cache
    - App.crashBrower()...
    - App.setCrashDumpDir(string dir)
    - App.getProxyForURL(string url)
    - App.setProxyConfig(string config)
    - App.addOriginAccessWhitelistEntry...
    - App.on('reopen', callback)
### Window API
    var gui = require('nw.gui');
    var currentWindow = gui.Window.get();
    var extraWindow = gui.Window.get(
        window.open('window.html', {
            position: 'center',
            width: 640,
            height: 480,
            focus: true
        });
    );
    console.log({
        'x': currentWindow.x,
        'y': currentWindow.y,
        'height': currentWindow.width,
        'width': currentWindow.height
    });
    Window.on('minimize', callback);
    Window.on('restore', callback);
    Window.on('maximize', callback);
    Window.on('unmaximize', callback);
    Window.on('focus', callback);
    Window.on('blur', callback);
    currentWindow.isFullscreen = true;
### 
    // manifest to make no menu and no border
    {
        "name":"My frameless App",
        "main":"index.html",
        "window": {
            "frame": false,
            "toolbar": false
        }
    }
- Other Window APIs
    - Window.title
    - Window.cookies.*
    - Window.menu
    - Window.reload()
    - Window.reloadIgnreingCache()
    - Window.setAlwaysOnTop()
    - Window.isTransparent
    - Window.setTransparent(transparent)
    - Window.showDevTools([id | iframe, headless])
    - Window.closeDevTools()
### Screen APIs
### Menu APIs
- 3 types of menus
    - Contextual menus : right-clicking
    - Window menus
    - Tray icon menus
### 
    var gui = require('nw.gui');
    var menu = ew gui.Menu();
    menu.append(new gui.MenuItem({
        label: 'Menu Item'
    }));
    var menuItem = new gui.MenuItem({
        type: 'checkbox', // normal|checkbox|separator
        label: 'Menu Checkbox',
        icon: 'icon16.png',
        tooltip: 'hello World!',
        click: function() {
            // Do something on click
        },
        enabled: true,
        checked: false, // Only for checkboxes
        key: 'M',
        modifiers: 'ctrl-shift',
        iconIsTemplate: true, // Only on Mac OS
        submenu:new gui.Menu() // Accept a Menu Object
    });
### File Dialogs
    <input id = "fileDialog" type="file">
    <script>
    function FileDialog(inputId, callback) {
        var fd = this;
        fd.chooser = document.querySelector(inputId);
        fd.chooser.addEventListener("change", function() {
            var path = this.value;
            callback(path);
            fd.chooser.value = '';
        });
        fd.open = function() {
            fd.chooser.click();
        }
        return fd;
    }
    var myFileDialog = new FileDialog('#fileDialog', function(path) {
        console.log(path);
    })
    </script>
    <a href="#" onclick="myFileDialog.open();">Open file</a>

    <input type="file" multiple /> // multiple files
    <input type="file" accept=".doc,.docx,.xml,application/msword">
    <input type="file" nwdirectory /> // open dir
    <input type="file" nwsaveas /> // save file
    <input type="file" nwworkingdir="C:\Documents" />