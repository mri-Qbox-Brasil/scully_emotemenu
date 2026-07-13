# 💃 Scully Emote Menu - Manual de Funcionalidades

Menu de emotes abrangente e rico em funcionalidades para FiveM com suporte a props, animações sincronizadas, efeitos de partículas e integração com frameworks.

**Versão:** 1.9.9f | **Framework:** Todos | **Licença:** MIT

---

## 🎯 O que o Scully Emote Menu faz

O Scully Emote Menu é um sistema completo de animações para FiveM que oferece mais de 500+ emotes, incluindo danças, ações, expressões faciais e estilos de caminhada. Suporta emotes com props (objetos), emotes sincronizados entre jogadores, efeitos de partículas (PTFX) e persistência de configurações.

---

## ⚙️ Como funciona

O sistema gerencia animações através de:
- **Cliente:** Execução de animações, controle de props, sincronização com outros jogadores
- **Servidor:** Gerenciamento de emotes sincronizados, validações
- **Configuração:** `config.lua` e arquivos em `data/` para definições de emotes

As animações são categorizadas e podem ser acessadas via menu NUI, comandos ou binds de teclas.

---

## 🔧 Configuração

Edite `config.lua`:

```lua
Config = {
    EnableEmoteBinds = true,           -- Sistema de teclas de atalho
    EnableNSFWEmotes = false,          -- Habilitar emotes NSFW (18+)
    EnableGangEmotes = true,           -- Emotes de gang
    EnableSocialMovement = true,       -- Movimentos sociais (LGBTQ/BLM)
    EnableAutoPtfx = false,            -- Reproduzir efeitos automaticamente
    HidePedMenu = false,               -- Ocultar menu de ped
    
    EmoteMenuCommand = 'emotes',       -- Comando para abrir menu
    
    -- Teclas de atalho (configuráveis nas settings do jogo)
    Emote1 = 'F1',
    Emote2 = 'F2',
    Emote3 = 'F3',
    Emote4 = 'F4',
    Emote5 = 'F5',
    Emote6 = 'F6',
    Emote7 = 'F7',
    Emote8 = 'F8',
    Emote9 = 'F9',
    Emote10 = 'F10',
    
    -- Configurações de props
    PropExtractor = false,             -- Gerar lista para anti-cheat
    
    -- Filtros
    BlacklistedEmotes = {},            -- Emotes bloqueados
    WhitelistedPeds = {}               -- Peds permitidos
}
```

### Tipos de Emote em `data/`
| Chave | Descrição |
|-----|-----------|
| `NSFW = true` | Oculto do menu (18+) |
| `Gang = true` | Oculto (relacionado a gangs) |
| `SocialMovement = true` | Oculto (movimentos sociais) |
| `Hide = true` | Sempre oculto (apenas comando/export) |
| `BlockBinding = true` | Impede vinculação a teclas |
| `PedTypes` | Restrição a tipos de ped |
| `Placement = true` | Seleção de posicionamento |
| `SkipRequest = true` | Pula solicitação em emotes compartilhados |
| `Auto = true` | Reproduz efeitos automaticamente |

---

## 📤 Exports

### Exports do Cliente
| Export | Descrição | Parâmetros |
|--------|-----------|-------------|
| `toggleMenu` | Alterna menu de emotes | None |
| `closeMenu` | Fecha menu | None |
| `getCurrentExpression` | Obtém expressão atual | None |
| `setExpression` | Define expressão | `expressionName` (string) |
| `resetExpression` | Reseta expressão | None |
| `getCurrentWalk` | Obtém estilo de caminhada | None |
| `setWalk` | Define estilo de caminhada | `walkName` (string) |
| `resetWalk` | Reseta caminhada | None |
| `isInEmote` | Verifica se está em animação | None |
| `getLastEmote` | Obtém último emote | None |
| `registerEmote` | Registra emote customizado | `emoteData` (table) |
| `playRegisteredEmote` | Reproduz emote registrado | `emoteName` (string) |
| `playEmote` | Reproduz emote diretamente | `emoteData` (table), `variant` (int) |
| `playEmoteByCommand` | Reproduz por comando | `command` (string), `variant` (int) |
| `cancelEmote` | Para animação atual | None |
| `isLimited` | Verifica se limitado | None |
| `setLimitation` | Alterna limitações | `limited` (boolean) |
| `listEmotes` | Lista emotes por categoria | `emoteType` (string) |

---

## 📡 Eventos

### Eventos do Cliente
| Evento | Descrição | Parâmetros |
|--------|-----------|-------------|
| `scully_emotemenu:toggleMenu` | Alterna menu | None |
| `scully_emotemenu:closeMenu` | Fecha menu | None |
| `scully_emotemenu:setExpression` | Define expressão | `expressionName` (string) |
| `scully_emotemenu:resetExpression` | Reseta expressão | None |
| `scully_emotemenu:setWalk` | Define caminhada | `walkName` (string) |
| `scully_emotemenu:resetWalk` | Reseta caminhada | None |
| `scully_emotemenu:registerEmote` | Registra emote | `emoteData` (table) |
| `scully_emotemenu:playRegisteredEmote` | Reproduz emote | `emoteName` (string) |
| `scully_emotemenu:play` | Reproduz emote | `emoteData` (table), `variant` |
| `scully_emotemenu:playByCommand` | Reproduz por comando | `command` (string), `variant` |
| `scully_emotemenu:cancelAnimation` | Cancela animação | None |
| `scully_emotemenu:toggleLimitation` | Alterna limitação | `limited` (boolean) |

---

## 🎮 Comandos

| Comando | Descrição | Permissão |
|---------|-----------|------------|
| `/emotes` | Abre menu de emotes | Todos os Jogadores |
| `/e [emote]` | Reproduz emote por nome | Todos os Jogadores |
| `/emote [emote]` | Reproduz emote por nome | Todos os Jogadores |

### Exemplos de Comandos
```
/e dance4       -- Executa o emote 'dance4'
/emote sit     -- Executa o emote 'sit'
```

---

## 🔗 Integrações

### Frameworks Suportados
- **QBCore** - Suporte completo
- **ESX** - Suporte completo
- **ox_core** - Suporte completo
- **Standalone** - Suporte completo

### Dependências
- **ox_lib** (obrigatório) - UI e utilitários

### Integração com Menu Radial
O scully_emotemenu integra com menus radiais para acesso rápido.

### Compatibilidade com Eventos QBCore
Suporta eventos do QBCore para controle de animações.

---

## 💡 Casos de Uso

### Registrar Emote Personalizado (Cliente)
```lua
exports['scully_emotemenu']:registerEmote({
    Command = 'dance4',
    Name = 'Dance 4',
    Category = 'Dances',
    Animation = {
        Dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity',
        Clip = 'hi_dance_facedj_11_v2_male^5',
        Duration = -1,
        Flags = {
            Loop = true,
            Move = false
        }
    },
    Prop = {
        model = 'prop_glowstick_01',
        bone = 57005,
        position = {x = 0.0, y = 0.0, z = 0.0},
        rotation = {x = 0.0, y = 0.0, z = 0.0}
    }
})
```

### Reproduzir Emote (Cliente)
```lua
exports['scully_emotemenu']:playEmote({
    Animation = {
        Dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity',
        Clip = 'hi_dance_facedj_11_v2_male^5',
    }
}, 0)
```

### Definir Estilo de Caminhada (Cliente)
```lua
exports['scully_emotemenu']:setWalk('move_m@hipster@a')
```

### Verificar se Jogador está em Emote
```lua
if exports['scully_emotemenu']:isInEmote() then
    print("O jogador está reproduzindo um emote")
end
```

### Emote Sincronizado
```lua
-- Solicitar emote sincronizado com outro jogador
TriggerServerEvent('scully_emotemenu:requestSharedEmote', targetPlayer, 'highfive')
```

---

## 🎪 Emotes com Props

O sistema gerencia automaticamente a limpeza de props:
```lua
{
    Command = 'guitar',
    Name = 'Tocar Guitarra',
    Animation = {...},
    Prop = {
        model = 'prop_guitar_01',
        bone = 57005,              -- Mão direita
        position = {x = 0.08, y = -0.03, z = -0.09},
        rotation = {x = 0.0, y = 180.0, z = 90.0}
    }
}
```

---

## ✨ Efeitos de Partículas (PTFX)

```lua
{
    Command = 'magic',
    Name = 'Magia',
    Animation = {...},
    Ptfx = {
        asset = 'scr_rcbarry2',
        name = 'scr_rcbarry2_fib_glow',
        offset = {x = 0.0, y = 0.0, z = 0.5},
        rotation = {x = 0.0, y = 0.0, z = 0.0},
        size = 1.0,
        color = {r = 255, g = 0, b = 0}  -- Vermelho
    }
}
```

---

## 🔧 Extrator de Props para Anti-Cheat

Para sistemas anti-cheat, gere uma lista de props:
1. Defina `PropExtractor = true` em config.lua
2. Reinicie o recurso
3. `prop_dump.lua` será gerado na pasta do recurso
4. Adicione esses props à whitelist do seu anti-cheat

---

## ⚠️ Solução de Problemas

### Emotes não reproduzem
- Verifique se o ox_lib está rodando
- Confirme que a animação existe no jogo
- Olhe o console (F8) para erros de dicionário de animação

### Props não aparecem
- Verifique se o modelo do prop existe
- Confirme que o bone ID está correto
- Verifique se o prop não está bloqueado pelo anti-cheat

### Menu não abre
- Verifique se o comando `/emotes` está funcionando
- Confirme que `EmoteMenuCommand` está configurado
- Verifique erros no console do cliente

### Emotes sincronizados não funcionam
- Verifique se o jogador alvo aceitou a solicitação
- Confirme que ambos os jogadores têm o recurso
- Verifique se o emote suporta sincronização

### Estilo de caminhada não persiste
- Verifique se o estilo de caminhada existe
- Confirme que o jogo não reinicia a animação
- Verifique se não há conflito com outros recursos

### Emotes NSFW aparecendo
- Defina `EnableNSFWEmotes = false` em config.lua
- Reinicie o recurso após alterar

---

## 📚 Links
- [Documentação](https://docs.scully.dev)
- [Discord](https://discord.gg/scully)
- [GitHub](https://github.com/ScullyyDel/EmoteMenu)
