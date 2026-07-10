-- Destaca a aba ATIVA do Chrome numa janela nova e snapa na metade direita.
-- (AppleScript não move a aba preservando estado: reabre a URL numa janela nova
--  e fecha a aba original — visualmente é o mesmo "tirar a aba pra fora".)
-- Snap via URL scheme do Rectangle. Atalho global ⌃⌥⌘→ (skhd).
-- Dica: aperte e não clique em outra janela por ~1s (o snap age na janela em foco).

set didDetach to false

with timeout of 60 seconds
	tell application "Google Chrome"
		activate
		if (count windows) is 0 then make new window
		set srcWin to front window
		if (count of tabs of srcWin) is less than 2 then
			-- só uma aba: a própria janela já é a "aba destacada"
			set index of srcWin to 1
		else
			set theURL to URL of active tab of srcWin
			set theIdx to active tab index of srcWin
			set newWin to make new window
			set URL of active tab of newWin to theURL
			set index of newWin to 1
			set didDetach to true
		end if
	end tell
end timeout

-- alinha a janela nova ANTES de fechar a aba original
delay 0.5
do shell script "open 'rectangle://execute-action?name=right-half'"

-- fecha a aba original só depois do snap (fechar antes rouba o foco e erra o alvo)
if didDetach then
	delay 0.4
	with timeout of 60 seconds
		tell application "Google Chrome"
			close tab theIdx of srcWin
			set index of newWin to 1
		end tell
	end timeout
end if
