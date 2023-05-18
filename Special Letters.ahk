#Requires AutoHotkey v2.0

#SingleInstance Force

;#NoTrayIcon

SetWorkingDir(A_ScriptDir)

TraySetIcon("Icons\keyboard.ico")

a_accents := ["à", "â", "ɑ", "ɒ", "æ", "ã"]

a_cap_accents := ["À", "Â", "Æ"]

e_accents := ["é", "è", "ê", "ɛ", "ə", "ɜ", "ɛ̃", "ë"]

e_cap_accents := ["É", "È", "Ê", "Ë"]

i_accents := ["î", "ï", "ɪ"]

i_cap_accents := ["Î", "Ï"]

o_accents := ["ô", "œ", "ɔ", "ʊ", "ɔ̃"]

o_accents := ["Ô", "Œ"]

u_accents := ["ù", "û", "ʌ", "ũ", "ø"]

u_cap_accents := ["Ù", "Ù", "Ü"]

s_accents := ["ʃ"]

z_accents := ["ʒ"]

t_accents := ["θ", "ð"]

r_accents := ["ʁ"]

n_accents := ["ɲ","ŋ"]

d_accents := ["ð"]

c_accents := ["ç"]

c_cap_accents := ["Ç"]

accent_counter := 1
accents_gui_hwnd := ""
letter := ""

accents_gui_show() {
    global
    try_destroy
    text_list := []
    accents_gui := Gui("-Caption +AlwaysOnTop", letter " accents")
    accents_gui.SetFont("caqua s20", "Comic Sans MS")
    accents_gui.BackColor := "0c0c0c"
    For k, v in %letter%_accents {
        if (k == 1) {
            text_list.Push(accents_gui.AddText(, v))
        }
        else {
            text_list.Push(accents_gui.AddText("cwhite x+20", v))
        }
    }
    accents_gui.OnEvent("Escape", gui_destroy)
    accents_gui.OnEvent("Close", gui_destroy)
    accents_gui.Show
    accents_gui_hwnd := accents_gui.Hwnd
}

accents_gui_cycle() {
    global
    text_list[accent_counter].Opt("cwhite")
    accent_counter += 1
    if (accent_counter > %letter%_accents.Length) {
        accent_counter := 1
    }
    text_list[accent_counter].Opt("caqua")
}

<+>+a:: {
    letter_hotkey("a")
}

^<+>+a:: {
    letter_hotkey("a_cap")
}

<+>+e:: {
    letter_hotkey("e")
}

^<+>+e:: {
    letter_hotkey("e_cap")
}

<+>+i:: {
    letter_hotkey("i")
}

^<+>+i:: {
    letter_hotkey("i_cap")
}

<+>+o:: {
    letter_hotkey("o")
}

^<+>+o:: {
    letter_hotkey("o_cap")
}

<+>+u:: {
    letter_hotkey("u")
}

^<+>+u:: {
    letter_hotkey("u_cap")
}

<+>+y:: {
    letter_hotkey("u")
}

^<+>+y:: {
    letter_hotkey("u_cap")
}

<+>+s:: {
    letter_hotkey("s")
}

<+>+z:: {
    letter_hotkey("z")
}

<+>+t:: {
    letter_hotkey("t")
}

<+>+r:: {
    letter_hotkey("r")
}

<+>+n:: {
    letter_hotkey("n")
}

<+>+d:: {
    letter_hotkey("d")
}

<+>+c:: {
    letter_hotkey("c")
}

^<+>+c:: {
    letter_hotkey("c_cap")
}

<^>^<+>+e:: {
    ExitApp
}

letter_hotkey(letter_to_use) {
    global
    if (letter != letter_to_use) {
        try_destroy
    }
    letter := letter_to_use
    if !WinExist("ahk_id " accents_gui_hwnd) {
        accents_gui_show()
        SetTimer(l_shift_up, -1)
        SetTimer(r_shift_up, -1)
    }
    else {
        accents_gui_cycle()
    }
}

gui_destroy(guiobj, * ) {
    global
    guiobj.Destroy
    accent_counter := 1
}

l_shift_up() {
    global
    KeyWait("LShift")
    if WinExist("ahk_id " accents_gui_hwnd) {
        try_destroy
        Send(%letter%_accents[accent_counter])
        accent_counter := 1
    }
}

r_shift_up() {
    global
    KeyWait("RShift")
    if WinExist("ahk_id " accents_gui_hwnd) {
        try_destroy
        Send(%letter%_accents[accent_counter])
        accent_counter := 1
    }
}

try_destroy() {
    global
    Try {
        accents_gui.Destroy
    }
}