**Português** · [English](README.en.md)

# scripts

Scripts de automação do Google Chrome no macOS via AppleScript, disparados por atalhos globais com [skhd](https://github.com/koekeishiya/skhd).

## Scripts

| Script | Atalho | O que faz |
|---|---|---|
| `chrome-focus-meet.applescript` | ⌃⌥⌘⇧M | Varre janelas/abas do Chrome, põe a aba do Google Meet (`meet.google.com`) em evidência: ativa a aba, traz a janela pra frente e foca o Chrome. Se não achar, não faz nada. |
| `chrome-focus-calendar.applescript` | ⌃⌥⌘⇧C | Mesmo comportamento, para a aba do Google Calendar (`calendar.google.com`). |
| `chrome-split-side-by-side.applescript` | ⌃⌥⌘↓ | Abre UMA janela nova do Chrome e a encaixa na metade direita da tela. NÃO move nenhuma outra janela (a que estava em foco permanece onde está). |
| `chrome-detach-tab-right.applescript` | ⌃⌥⌘→ | "Destaca" a aba ativa numa janela nova encaixada à direita. Como AppleScript não move a aba preservando estado, ele reabre a URL da aba ativa numa janela nova e fecha a aba original (visualmente igual a arrastar a aba pra fora; perde histórico/scroll daquela aba). Se a janela só tem uma aba, apenas snapa ela à direita. |

## Como funciona

**Scripts de foco (meet/calendar):** percorrem `windows` e `tabs` do Chrome em busca da URL alvo. Ao encontrar, definem `active tab index` para ativar a aba, usam `set index ... to 1` para trazer a janela pra frente e chamam `activate` para focar o Chrome.

**Scripts de janela (split-side-by-side e detach-tab-right):** usam `make new window` para criar ou reorganizar janelas e depois fazem o snap chamando o URL scheme do Rectangle (`open 'rectangle://execute-action?name=right-half'`), que age sobre a janela em foco naquele momento.

## Dependências

- macOS + Google Chrome
- [skhd](https://github.com/koekeishiya/skhd) para os atalhos globais — `brew install koekeishiya/formulae/skhd`
- [Rectangle](https://rectangleapp.com/) para o snap via URL scheme `rectangle://execute-action` — necessário apenas para `chrome-split-side-by-side.applescript` e `chrome-detach-tab-right.applescript`

## Instalação

1. Copie os `.applescript` para `~/Library/Scripts/` (ou outra pasta; ajuste os caminhos no `skhdrc.example` conforme necessário)
2. Instale o skhd e inicie o serviço:
   ```sh
   brew install koekeishiya/formulae/skhd
   skhd --start-service
   ```
3. Copie as linhas de `skhdrc.example` para `~/.config/skhd/skhdrc`
4. Conceda permissões em **Ajustes do Sistema → Privacidade e Segurança**:
   - **Acessibilidade** para `/opt/homebrew/bin/skhd`
   - **Automação**: skhd → Google Chrome (o macOS pede automaticamente na primeira vez que um atalho dispara)
5. Instale o [Rectangle](https://rectangleapp.com/) (necessário para os dois scripts de snap)

## Gotchas

- **Os scripts de janela levam ~1,5 s.** O snap age na janela em foco — se você clicar em outra janela durante a execução, o foco muda e o snap erra o alvo. Pressione o atalho e espere ~1 s sem clicar em nada.
- **Nomes de ação do Rectangle no skhd usam kebab-case** (`right-half`, `left-half`). Keycodes hexadecimais precisam ser maiúsculos no skhd — por isso as teclas `down` e `right` foram usadas pelo nome em vez de códigos hex.
