window.addEventListener('message', (event) => {
    if (event.data.action === 'startCapture') {
        document.body.style.display = 'flex';
    } else if (event.data.action === 'stopCapture') {
        document.body.style.display = 'none';
    }
});

document.addEventListener('keydown', (event) => {
    if (document.body.style.display === 'none') return;

    event.preventDefault();

    let keyName = event.key;
    let code = event.code;

    // Mapping for specific keys to match FiveM format if needed,
    // but mostly we will pass the code or key and handle it in Lua or just use the JS code.
    // FiveM RegisterKeyMapping usually takes standard names like 'F5', 'BACKSPACE', 'L'.

    // Comprehensive mapping for FiveM 'bind' command compat
    const fiveMKeys = {
        'Space': 'SPACE',
        'Backspace': 'BACK',
        'Tab': 'TAB',
        'Enter': 'RETURN',
        'ShiftLeft': 'LSHIFT',
        'ShiftRight': 'RSHIFT',
        'ControlLeft': 'LCONTROL',
        'ControlRight': 'RCONTROL',
        'AltLeft': 'LMENU',
        'AltRight': 'RMENU', // or RIGHTALT
        'CapsLock': 'CAPITAL',
        'Escape': 'ESCAPE',
        'PageUp': 'PRIOR',
        'PageDown': 'NEXT',
        'End': 'END',
        'Home': 'HOME',
        'ArrowLeft': 'LEFT',
        'ArrowUp': 'UP',
        'ArrowRight': 'RIGHT',
        'ArrowDown': 'DOWN',
        'Insert': 'INSERT',
        'Delete': 'DELETE',
        'Numpad0': 'NUMPAD0',
        'Numpad1': 'NUMPAD1',
        'Numpad2': 'NUMPAD2',
        'Numpad3': 'NUMPAD3',
        'Numpad4': 'NUMPAD4',
        'Numpad5': 'NUMPAD5',
        'Numpad6': 'NUMPAD6',
        'Numpad7': 'NUMPAD7',
        'Numpad8': 'NUMPAD8',
        'Numpad9': 'NUMPAD9',
        'NumpadMultiply': 'NUMPADSTAR',
        'NumpadAdd': 'NUMPADPLUS',
        'NumpadSubtract': 'NUMPADMINUS',
        'NumpadDecimal': 'NUMPADPERIOD',
        'NumpadDivide': 'NUMPADSLASH',
        'NumpadEnter': 'NUMPADENTER',
        'F1': 'F1', 'F2': 'F2', 'F3': 'F3', 'F4': 'F4', 'F5': 'F5',
        'F6': 'F6', 'F7': 'F7', 'F8': 'F8', 'F9': 'F9', 'F10': 'F10',
        'F11': 'F11', 'F12': 'F12',
        'Semicolon': 'SEMICOLON',
        'Equal': 'EQUALS',
        'Comma': 'COMMA',
        'Minus': 'MINUS',
        'Period': 'PERIOD',
        'Slash': 'SLASH',
        'Backquote': 'GRAVE',
        'BracketLeft': 'LBRACKET',
        'Backslash': 'BACKSLASH',
        'BracketRight': 'RBRACKET',
        'Quote': 'APOSTROPHE'
    };

    if (fiveMKeys[code]) {
        keyName = fiveMKeys[code];
    } else if (code.startsWith('Key')) {
        keyName = code.substring(3).toUpperCase();
    } else if (code.startsWith('Digit')) {
        keyName = code.substring(5);
    } else {
        keyName = code.toUpperCase(); // Fallback
    }

    // Send back to client
    fetch(`https://${GetParentResourceName()}/capturedKey`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify({
            key: keyName,
            code: code,
            alt: event.altKey,
            ctrl: event.ctrlKey,
            shift: event.shiftKey
        })
    });

    // Hide UI immediately after capture
    document.body.style.display = 'none';
    fetch(`https://${GetParentResourceName()}/closeUI`, { method: 'POST' });
});

document.addEventListener('mousedown', (event) => {
    if (document.body.style.display === 'none') return;
    // Allow canceling with right click
    if (event.button === 2) {
        document.body.style.display = 'none';
        fetch(`https://${GetParentResourceName()}/closeUI`, { method: 'POST' });
    }
});
