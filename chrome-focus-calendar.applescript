-- ⌃⌥⌘⇧C → traz o foco para a aba do Google Calendar (https://calendar.google.com/*)
-- Varre todas as janelas/abas do Chrome, ativa a primeira aba do Calendar,
-- traz a janela para frente e dá foco no Chrome. Se não houver, não faz nada.

tell application "Google Chrome"
	if not running then return
	set foundWin to missing value
	set foundIdx to 0
	repeat with w in windows
		set tabIndex to 0
		repeat with t in tabs of w
			set tabIndex to tabIndex + 1
			if (URL of t) contains "calendar.google.com" then
				set foundWin to w
				set foundIdx to tabIndex
				exit repeat
			end if
		end repeat
		if foundWin is not missing value then exit repeat
	end repeat
	if foundWin is not missing value then
		set active tab index of foundWin to foundIdx
		set index of foundWin to 1
		activate
	end if
end tell
