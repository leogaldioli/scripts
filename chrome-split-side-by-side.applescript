-- Abre UMA janela nova do Chrome e encaixa ela na metade direita.
-- NÃO toca em nenhuma outra janela (a que estava em foco fica onde está).
-- Snap via URL scheme do Rectangle (execute-action). Atalho global ⌃⌥⌘↓ (skhd).
-- Dica: aperte e não clique em outra janela por ~1s
-- (o snap age na janela em foco; clicar fora rouba o foco e erra o alvo).

with timeout of 60 seconds
	tell application "Google Chrome"
		activate
		make new window
		set index of window 1 to 1
	end tell
end timeout
delay 0.4
do shell script "open 'rectangle://execute-action?name=right-half'"
