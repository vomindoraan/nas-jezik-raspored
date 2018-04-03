#SingleInstance force

#Include KeyboardLayout.ahk
#Include LanguageCodes.ahk

hr      = Croatian
en_GB   = English (United Kingdom)
en_US   = English (United States)
de_AT   = German (Austrian)
de_DE   = German (Standard)
de_CH   = German (Swiss)
sr_Cyrl = Serbian (Cyrillic)
sr_Latn = Serbian (Latin)

kl_code := GetKeyboardLayout() & 0xFFFF
kl_name := GetLanguageName(kl_code)
if (kl_name = "") {
    kl_name := "<unknown>"
}

map := { (hr):      GetLanguageCode(hr)
       , (en_GB):   GetLanguageCode(en_GB)
       , (en_US):   GetLanguageCode(en_US)
       , (de_AT):   GetLanguageCode(de_AT)
       , (de_DE):   GetLanguageCode(de_DE)
       , (de_CH):   GetLanguageCode(de_CH)
       , (sr_Cyrl): GetLanguageCode(sr_Cyrl)
       , (sr_Latn): GetLanguageCode(sr_Latn)
       , (kl_name): kl_code }

for k, v in map {
    list1 .= k . (k = kl_name ? "||" : "|")
    list2 .= k . (k = sr_Cyrl ? "||" : "|")
}

Gui, Add, Text,, Osnovni raspored:
Gui, Add, DropDownList, vFirst, %list1%
Gui, Add, Text,, Drugi raspored:
Gui, Add, DropDownList, vSecond, %list2%
Gui, Add, Text,, Prečica za promenu rasporeda:
Gui, Add, Hotkey, vToggleKey, CapsLock
Gui, Add, Text,, Prečica za prekid programa:
Gui, Add, Hotkey, vCloseKey, ^CapsLock
Gui, Add, Button, default gSubmit, &Pokreni
Gui, Add, Button, yp x+m gGuiClose, &Otkaži
Gui, Add, Link, x+m, <a href="https://www.facebook.com/groups/835693853184105">Naš jezik</a>
Gui, Add, Link, y+m, <a href="https://github.com/vomindoraan">GitHub</a>
Gui, Show,, Raspored tastature
return

Submit:
    Gui, Submit
    Hotkey, %ToggleKey%, ToggleLayout
    Hotkey, %CloseKey%, GuiClose
    return

ToggleLayout:
    SetKeyboardLayout((toggle := !toggle) ? map[Second] : map[First])
    return

Escape::
GuiClose:
    ExitApp
