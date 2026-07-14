# scully_emotemenu — Manual

Menu de animações para FiveM com emotes, danças, cenários, expressões faciais, estilos de caminhada, emotes com props, emotes sincronizados entre dois jogadores e efeitos de partícula. Standalone, com camada de compatibilidade opcional para QBCore.

---

## Sumário

1. [Dependências](#dependências)
2. [Instalação](#instalação)
3. [Configuração](#configuração)
4. [Comandos](#comandos)
5. [Teclas](#teclas)
6. [Categorias de animação](#categorias-de-animação)
7. [Estrutura de uma animação](#estrutura-de-uma-animação)
8. [Emotes customizados](#emotes-customizados)
9. [Binds de emote](#binds-de-emote)
10. [Emotes sincronizados](#emotes-sincronizados)
11. [Prop dump](#prop-dump)
12. [Integrações](#integrações)
13. [Entrypoints para outros recursos](#entrypoints-para-outros-recursos)
14. [Localização](#localização)
15. [Estrutura de arquivos](#estrutura-de-arquivos)

---

## Dependências

| Recurso | Obrigatório | Observação |
|---|---|---|
| `ox_lib` | Sim | Declarado no `fxmanifest`. Menus, radial, notificações, textUI, keybinds, callbacks |
| OneSync | Sim | Declarado como dependência `/onesync`. Necessário para props em rede e emotes sincronizados |
| Artifacts do servidor | Sim | Build mínima **5848** (`/server:5848`) |
| `qb-core` | Não | Se estiver rodando, o `compat/qbcore.lua` ativa os eventos legacy `animations:*` e bloqueia emotes quando o jogador está morto, algemado ou em last stand |

Não usa framework, banco de dados nem ACE. Funciona standalone.

---

## Instalação

1. Copie a pasta `scully_emotemenu` para `resources/`.
2. Adicione ao `server.cfg`:
   ```
   ensure scully_emotemenu
   ```
3. A pasta `stream/` já traz as animações e props customizados; os `.ytyp` são declarados no `fxmanifest.lua` e carregam sozinhos.
4. Ajuste o idioma e as teclas em `config.lua`.
5. **Conflitos** — não rode junto com outro menu de emotes (`rpemotes`, `dpemotes`, `qb-smallresources` com emotes). Os comandos `/e`, `/emote` e `/w` colidem, e dois recursos disputando `TaskPlayAnim` no mesmo ped brigam entre si.

No boot, o servidor consulta o GitHub do autor e avisa no console se a versão instalada (`1.9.9f`) está desatualizada.

---

## Configuração

Tudo fica em `config.lua`.

| Campo | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `Language` | string | Sim | Idioma do menu. Só é usado se a convar `ox_locale` não estiver definida. Padrão: `pt-br` |
| `EnableSearch` | bool | Não | Mostra a opção de busca de animação no menu principal |
| `EnablePropDump` | bool | Não | Regrava o `prop_dump.lua` a cada start do recurso. Ver [Prop dump](#prop-dump) |
| `EnableEmotePreview` | bool | Não | Permite pré-visualizar um emote num clone do seu personagem segurando **E** ao selecionar no menu |
| `EnableEmotePlacement` | bool | Não | Ativa o seletor de posição nos emotes com a flag `Placement` (encostar na parede, sentar em superfície etc.) |
| `EnableEmoteBinds` | bool | Não | Declarado no config, mas **não é lido pelo código atual** — o sistema de binds do `client/keybinds.lua` sempre carrega |
| `EnableWeaponBlock` | bool | Não | Impede tocar emote com arma na mão |
| `EnableAimShootBlock` | bool | Não | Cancela o emote quando o jogador mira ou atira |
| `CancelEmoteKey` | string | Não | Tecla de cancelar o emote. `''` desativa. Padrão: `F6` |
| `HandsUpKey` | string | Não | Tecla de mãos ao alto (segurar). `''` desativa. Vem desativada |
| `StanceKey` | string | Não | Tecla que cicla a postura (em pé → agachado → deitado). `''` desativa. Vem desativada |
| `PointKey` | string | Não | Tecla de apontar com o dedo, seguindo a câmera. `''` desativa. Padrão: `b` |
| `AllowedInVehicles` | bool | Não | `true` permite emotes dentro do carro (só a parte superior do corpo anima). `false` bloqueia |
| `EmoteCooldown` | number | Não | Milissegundos de espera entre um emote e o próximo |
| `EmotePlayCommands` | array | Sim | Comandos que tocam um emote. Padrão: `e`, `emote`, `eplay` |
| `WalkSetCommands` | array | Sim | Comandos que definem o estilo de caminhada. Padrão: `w`, `walk`, `andar` |
| `MenuOpenCommands` | array | Sim | Comandos que abrem o menu. Padrão: `em`, `emotemenu` |
| `MenuKeybind` | string | Não | Tecla que abre o menu, mapeada sobre o primeiro `MenuOpenCommands`. `''` desativa. Padrão: `F5` |
| `MenuPosition` | string | Não | Posição do menu: `top-left`, `top-right`, `bottom-left`, `bottom-right` |
| `NotificationPosition` | string | Não | Posição das notificações: `top`, `bottom`, `top-left`, `top-right`, `bottom-left`, `bottom-right` |
| `HelpAlertPosition` | string | Não | Posição do textUI de ajuda: `right-center`, `left-center`, `top-center` |
| `RagdollKeybind` | string | Não | Tecla que joga o personagem no chão (alterna). `''` desativa. Padrão: `u` |
| `PtfxKeybind` | string | Não | Tecla que dispara o efeito de partícula do emote atual. Padrão: `g` |
| `EnableAutoPtfx` | bool | Não | Emotes com a flag `Auto` no `Ptfx` disparam a partícula sozinhos, sem apertar a tecla |
| `EnableNSFWEmotes` | `true` \| `false` \| `'limited'` | Não | `false` remove os emotes NSFW do menu. `'limited'` os mantém, mas só toca se o statebag `allowNSFWEmotes` do jogador for verdadeiro — dá para liberar por zona ou por job de outro recurso |
| `EnableGangEmotes` | bool | Não | `false` remove os emotes marcados com `Gang` |
| `EnableSocialMovementEmotes` | bool | Não | `false` remove os emotes marcados com `SocialMovement` |
| `EnableConsumableEmotes` | bool | Não | `false` esconde a categoria de emotes de consumo (comer, beber, fumar) |
| `EnableSynchronizedEmotes` | bool | Não | `false` esconde a categoria de emotes sincronizados |
| `EnableAnimalEmotes` | bool | Não | `false` esconde a categoria de emotes de animais |
| `EnableRadialMenu` | bool | Não | Registra o item "Emotes" no radial do `ox_lib`, com submenus de caminhadas e expressões |

As três flags `EnableNSFWEmotes`, `EnableGangEmotes` e `EnableSocialMovementEmotes` **removem** a animação da lista inteira quando desligadas — ela some do menu, dos comandos e do radial. As flags `EnableConsumableEmotes`, `EnableSynchronizedEmotes` e `EnableAnimalEmotes` apenas escondem a categoria do menu; os comandos continuam funcionando.

---

## Comandos

Todos os comandos são de client, sem restrição de permissão.

| Comando | Permissão | Descrição |
|---|---|---|
| `/em`, `/emotemenu` | Qualquer jogador | Abre e fecha o menu de animações |
| `/e <emote> [variante]` | Qualquer jogador | Toca um emote pelo comando dele. O segundo argumento escolhe a variante do prop, quando o emote tiver `Variations` |
| `/emote <emote> [variante]` | Qualquer jogador | Alias de `/e` |
| `/eplay <emote> [variante]` | Qualquer jogador | Alias de `/e` |
| `/e c` | Qualquer jogador | Cancela o emote atual |
| `/e l` | Qualquer jogador | Lista todos os emotes disponíveis |
| `/w <caminhada>` | Qualquer jogador | Define o estilo de caminhada |
| `/walk <caminhada>`, `/andar <caminhada>` | Qualquer jogador | Aliases de `/w` |
| `/w c` | Qualquer jogador | Volta à caminhada padrão |
| `/w l` | Qualquer jogador | Lista todos os estilos de caminhada |

Os nomes dos comandos vêm de `EmotePlayCommands`, `WalkSetCommands` e `MenuOpenCommands` — renomeie no config se quiser outros.

---

## Teclas

| Tecla padrão | Nome do keybind | Ação |
|---|---|---|
| `F5` | (mapeada sobre `/em`) | Abre o menu |
| `F6` | `mri_Qbox-ecancel` | Cancela o emote atual |
| `b` | `point` | Aponta com o dedo, acompanhando a câmera. Aperte de novo para parar |
| `u` | `ragdoll` | Joga o personagem no chão. Aperte de novo para levantar |
| `g` | `playptfx` | Dispara o efeito de partícula do emote atual (quando o emote tem um) |
| — | `mri_Qbox-handsup` | Mãos ao alto enquanto segura. Desativado por padrão (`HandsUpKey = ''`) |
| — | `stance` | Cicla postura: em pé → agachado → deitado. Desativado por padrão (`StanceKey = ''`) |
| — | `emotebind_1` a `emotebind_10` | 10 slots de emote configuráveis. Sem tecla padrão |

Todas as teclas são remapeáveis pelo jogador em **Configurações > Controles > FiveM**.

---

## Categorias de animação

Cada categoria é um arquivo em `data/animations/`.

| Categoria | Arquivo | Conteúdo |
|---|---|---|
| `Emotes` | `emotes.lua` | Emotes gerais (ações, poses, gestos) |
| `DanceEmotes` | `dance_emotes.lua` | Danças |
| `PropEmotes` | `prop_emotes.lua` | Emotes que carregam um ou mais props |
| `ConsumableEmotes` | `consumable_emotes.lua` | Comer, beber, fumar |
| `SynchronizedEmotes` | `synchronized_emotes.lua` | Emotes em par, entre dois jogadores |
| `AnimalEmotes` | `animal_emotes.lua` | Emotes restritos a peds de animais |
| `Walks` | `walks.lua` | Estilos de caminhada |
| `Scenarios` | `scenarios.lua` | Cenários nativos do GTA (`WORLD_HUMAN_*`) |
| `Expressions` | `expressions.lua` | Expressões faciais (moods) |

Cada arquivo tem um par `_pt-br.lua` com os comandos e rótulos traduzidos — ver [Localização](#localização).

---

## Estrutura de uma animação

```lua
{
    Label = 'Adjust Tie',        -- nome exibido no menu
    Command = 'adjusttie',       -- comando usado em /e adjusttie
    Animation = 'try_tie_positive_a',
    Dictionary = 'clothingtie',
    Options = {
        Duration = 5000,
        Flags = {
            Move = true,
        },
    },
}
```

### Campos de topo

| Campo | Tipo | Descrição |
|---|---|---|
| `Label` | string | Nome exibido no menu, na busca e na listagem |
| `Command` | string | Identificador usado nos comandos e nos exports |
| `Animation` | string | Nome do clip |
| `Dictionary` | string | Dicionário de animação |
| `Walk` | string | Só em `Walks`. Clipset da caminhada, no lugar de `Animation`/`Dictionary` |
| `Scenario` | string | Só em `Scenarios`. Nome do cenário nativo |
| `Expression` | string | Só em `Expressions`. Nome do mood |
| `NSFW` | bool | Marca a animação como NSFW. Ver `EnableNSFWEmotes` |
| `Gang` | bool | Marca como emote de gangue. Ver `EnableGangEmotes` |
| `SocialMovement` | bool | Marca como emote de movimento social. Ver `EnableSocialMovementEmotes` |
| `PedTypes` | array | Restringe a animação a tipos de ped listados em `data/ped_types.lua` (`dogs`, `cats`, `birds`, …) |
| `Placement` | bool | Ativa o seletor de posição livre antes de tocar, quando `EnableEmotePlacement` está ligado |
| `SkipRequest` | bool | Só em `SynchronizedEmotes`. O alvo não precisa aceitar o convite |
| `Hide` | bool | Esconde a animação do menu e do radial. Ela continua acessível por comando e por export |

### `Options`

| Campo | Tipo | Descrição |
|---|---|---|
| `Duration` | number | Duração em ms. Ausente ou `-1` toca até ser cancelado |
| `Flags.Loop` | bool | Repete a animação |
| `Flags.Move` | bool | Permite andar durante a animação |
| `Props` | array | Props anexados. Cada um tem `Name` (modelo), `Bone`, `Placement` (offset e rotação) e, opcionalmente, `Variations` / `Variant` |
| `Ptfx` | table | Efeito de partícula: `Asset`, `Name`, `Placement`, `Color`, `CanHold` (segurar a tecla mantém o efeito), `AttachToProp`, `Auto` (dispara sozinho quando `EnableAutoPtfx`) |
| `Shared` | table | Só em `SynchronizedEmotes`. `OtherAnimation` aponta para o `Command` da animação que o outro jogador vai tocar |

---

## Emotes customizados

O arquivo `custom_emotes.lua` existe para você adicionar animações sem tocar nos arquivos de `data/animations/`, que são sobrescritos a cada atualização do recurso.

```lua
return {
    Walks = {},
    Scenarios = {},
    Expressions = {},
    Emotes = {
        {
            Label = 'Meu Emote',
            Command = 'meuemote',
            Animation = 'idle_a',
            Dictionary = 'anim@amb@nightclub@lazlow@ig1_hi@',
            Options = {
                Flags = { Loop = true },
            },
        },
    },
    PropEmotes = {},
    ConsumableEmotes = {},
    DanceEmotes = {},
    SynchronizedEmotes = {},
    AnimalEmotes = {}
}
```

As listas são concatenadas às nativas na inicialização, no client e no servidor. Guarde uma cópia deste arquivo antes de atualizar o recurso.

Para registrar emotes em runtime, a partir de outro recurso, use o export `registerEmote`.

---

## Binds de emote

O menu tem uma seção **Emote Keybinds** com 10 slots. Em cada slot você associa um comando de emote e um rótulo; a tecla em si é escolhida pelo jogador em **Configurações > Controles**, procurando por `Emote Bind Slot 1` a `10`.

Os binds são salvos localmente no KVP do cliente (`scully_emotemenu_binds_v2`), ou seja, ficam por máquina e sobrevivem a reconexões. O menu também permite exportar os binds para a área de transferência e limpar todos de uma vez.

---

## Emotes sincronizados

Um emote sincronizado toca duas animações em par — uma no jogador que iniciou e outra em quem aceitou. O campo `Options.Shared.OtherAnimation` liga uma à outra.

Fluxo:

1. O jogador toca o emote (ex.: `/e sbaseball`). O client procura o jogador mais próximo em **3 metros**.
2. O servidor entrega o convite ao alvo, que vê um alerta para aceitar ou recusar. Emotes com `SkipRequest = true` pulam esta etapa.
3. Ao aceitar, o servidor confere que os dois estão a menos de **5 metros** e dispara as duas animações, uma em cada cliente.

Cancelar o emote de qualquer um dos lados encerra a animação dos dois.

---

## Prop dump

Com `EnablePropDump = true`, o servidor varre todas as animações a cada start e regrava o `prop_dump.lua` na raiz do recurso com a lista completa de props usados por emotes, em formato de tabela de hashes:

```lua
return {
	[`p_amb_bottle_01`] = true,
	[`prop_cs_burger_01`] = true,
}
```

Serve para alimentar a whitelist de objetos do seu anti-cheat. Depois de gerar o arquivo, dá para desligar a flag para não regravá-lo a cada restart.

---

## Integrações

### QBCore (`compat/qbcore.lua`)

O arquivo só age se o `qb-core` estiver presente (`GetResourceState` diferente de `unknown`/`missing`). Ele registra os eventos legacy do `qb-smallresources`/`rpemotes` e os traduz para os exports oficiais, bloqueando a ação se o jogador estiver morto, em last stand ou algemado (metadados `isdead`, `inlaststand`, `ishandcuffed`).

| Evento legacy | Efeito |
|---|---|
| `animations:client:PlayEmote` | `playEmoteByCommand(data[1])` |
| `animations:client:EmoteCommandStart` | `playEmoteByCommand(data[1])`, respeitando também o estado de limitação |
| `animations:client:EmoteMenu` | `toggleMenu()` |
| `animations:client:ListEmotes` | `listEmotes('Emotes')` |
| `animations:client:Walk` | `setWalk(data[1])` |
| `animations:client:ListWalks` | `listEmotes('Walks')` |
| `animations:ToggleCanDoAnims` | `setLimitation(bool)` |

O comentário no topo do arquivo avisa que essa camada pode ser removida no futuro: prefira os exports oficiais em código novo.

### Radial do ox_lib

Com `EnableRadialMenu = true`, o recurso adiciona um item "Emotes" ao radial global do `ox_lib`, com submenus para caminhadas e expressões e uma opção de cancelar. Emotes com `Hide = true` não aparecem no radial.

---

## Entrypoints para outros recursos

Todos os exports são de **client**.

### Menu

```lua
exports.scully_emotemenu:toggleMenu()
exports.scully_emotemenu:closeMenu()

-- Abre um alerta listando as animações de uma categoria.
-- Categorias válidas: Emotes, Walks, Scenarios, Expressions, PropEmotes,
-- ConsumableEmotes, DanceEmotes, SynchronizedEmotes, AnimalEmotes.
exports.scully_emotemenu:listEmotes('Emotes')
```

### Tocar e cancelar

```lua
-- Toca pelo Command da animação. O 3º argumento é opcional e aplica o emote em outro ped.
exports.scully_emotemenu:playEmoteByCommand('adjusttie', variant, ped)

-- Toca passando a tabela da animação diretamente.
exports.scully_emotemenu:playEmote(emoteTable, variant)

exports.scully_emotemenu:cancelEmote()
```

### Emotes registrados

```lua
-- Registra uma animação em runtime, indexada pelo campo Name.
exports.scully_emotemenu:registerEmote({
    Name = 'meuemote',
    Type = 'Emotes',              -- 'Walks' faz o playRegisteredEmote chamar setWalk
    Animation = 'idle_a',
    Dictionary = 'anim@amb@nightclub@lazlow@ig1_hi@',
    Options = { Flags = { Loop = true } },
})

exports.scully_emotemenu:playRegisteredEmote('meuemote')
```

Emotes registrados assim não aparecem no menu — servem para outros recursos dispararem animações próprias reaproveitando o gerenciamento de props e partículas.

### Caminhada e expressão

```lua
local walk = exports.scully_emotemenu:getCurrentWalk()
exports.scully_emotemenu:setWalk('move_m@hipster@a')
exports.scully_emotemenu:resetWalk()

local expression = exports.scully_emotemenu:getCurrentExpression()
exports.scully_emotemenu:setExpression('mood_angry_1')
exports.scully_emotemenu:resetExpression()
```

Caminhada e expressão são persistidas no KVP do cliente (`animations_walkstyle` e `animations_expression`) e reaplicadas a cada spawn.

### Estado

```lua
-- true enquanto uma animação do recurso está tocando.
local inEmote = exports.scully_emotemenu:isInEmote()

-- Última animação tocada e a variante usada.
local emote, variant = exports.scully_emotemenu:getLastEmote()

-- Bloqueia o jogador de usar qualquer emote, comando ou tecla do recurso.
exports.scully_emotemenu:setLimitation(true)
local limited = exports.scully_emotemenu:isLimited()
```

Use `setLimitation(true)` em situações como algemas, morte ou minigames — é o mesmo gancho que o `compat/qbcore.lua` usa.

### Substituir notificação e textUI

```lua
exports.scully_emotemenu:customNotifyFn(function(type, message)
    -- type é 'error' ou 'success'
    exports.meu_hud:Notify(message, type)
end)

exports.scully_emotemenu:customHelpAlertFn(function(icon, text)
    exports.meu_hud:ShowHelp(text, icon)
end)
```

Permite trocar as notificações e o textUI do `ox_lib` pelos do seu HUD sem editar o recurso.

### Menu de binds

```lua
exports.scully_emotemenu:OpenBindMenu()
```

### Eventos de client

Espelham os exports, para quem prefere disparar por evento a partir do servidor.

```lua
TriggerClientEvent('scully_emotemenu:toggleMenu', src)
TriggerClientEvent('scully_emotemenu:closeMenu', src)
TriggerClientEvent('scully_emotemenu:cancelEmote', src)
TriggerClientEvent('scully_emotemenu:play', src, emoteTable, variant)
TriggerClientEvent('scully_emotemenu:playByCommand', src, 'adjusttie', variant)
TriggerClientEvent('scully_emotemenu:registerEmote', src, emoteTable)
TriggerClientEvent('scully_emotemenu:playRegisteredEmote', src, 'meuemote')
TriggerClientEvent('scully_emotemenu:setWalk', src, 'move_m@hipster@a')
TriggerClientEvent('scully_emotemenu:resetWalk', src)
TriggerClientEvent('scully_emotemenu:setExpression', src, 'mood_angry_1')
TriggerClientEvent('scully_emotemenu:resetExpression', src)
TriggerClientEvent('scully_emotemenu:toggleLimitation', src, true)
TriggerClientEvent('scully_emotemenu:listEmotes', src, 'Emotes')
```

### Statebags

| Statebag | Escopo | Descrição |
|---|---|---|
| `allowNSFWEmotes` | Player | Quando `EnableNSFWEmotes = 'limited'`, só libera os emotes NSFW se este statebag for verdadeiro. Defina por zona, propriedade ou job |
| `stance` | Player | Postura atual: `0` em pé, `1` agachado, `2` deitado |
| `ptfx` | Player | `true` enquanto o efeito de partícula do emote está sendo emitido. Sincronizado para os outros clientes |

---

## Localização

O idioma do menu é resolvido nesta ordem:

1. a convar **`ox_locale`** do servidor, se existir um `locales/<codigo>.lua` correspondente;
2. o `Config.Language`;
3. `en` como último recurso.

```
setr ox_locale "pt-br"
```

Note que a convar é `ox_locale` (com underline), não `ox:locale`.

Idiomas disponíveis em `locales/`: `cs`, `da`, `de`, `en`, `es`, `et`, `fa`, `fi`, `fr`, `hu`, `id`, `it`, `nl`, `no`, `pl`, `pt`, `pt-br`, `ro`, `ru`, `sv`, `tl`, `tr`, `vi`, `zhcn`, `zhtw`.

### Comandos traduzidos

Além das strings da interface, os arquivos `data/animations/*_pt-br.lua` traduzem os **comandos e rótulos das próprias animações**. Eles são carregados como aliases: a animação em inglês continua funcionando, e a versão traduzida vira um comando adicional apontando para a mesma animação. No menu, aparece só a variante do idioma escolhido — e a entrada em inglês só reaparece quando não existe tradução para ela.

Para adicionar um idioma novo, crie `locales/<codigo>.lua` seguindo a estrutura dos existentes. Traduzir os comandos das animações exige criar também os arquivos `data/animations/<categoria>_<codigo>.lua` e registrar o sufixo no `translationMapping` do `client/main.lua`.

---

## Estrutura de arquivos

```
scully_emotemenu/
├── client/
│   ├── main.lua              — menu, radial, comandos, teclas, props, ptfx, emotes sincronizados
│   └── keybinds.lua          — 10 slots de bind de emote, persistidos em KVP
├── server/
│   └── main.lua              — spawn e limpeza de props, roteamento dos emotes sincronizados, prop dump
├── compat/
│   └── qbcore.lua            — eventos legacy animations:* (só ativa se o qb-core existir)
├── data/
│   ├── animations/
│   │   ├── emotes.lua                  — emotes gerais
│   │   ├── dance_emotes.lua            — danças
│   │   ├── prop_emotes.lua             — emotes com props
│   │   ├── consumable_emotes.lua       — comer, beber, fumar
│   │   ├── synchronized_emotes.lua     — emotes em par
│   │   ├── animal_emotes.lua           — emotes de peds animais
│   │   ├── walks.lua                   — estilos de caminhada
│   │   ├── scenarios.lua               — cenários nativos
│   │   ├── expressions.lua             — expressões faciais
│   │   └── *_pt-br.lua                 — comandos e rótulos traduzidos, carregados como aliases
│   └── ped_types.lua         — grupos de modelos de ped (dogs, cats, birds…) usados pela flag PedTypes
├── locales/                  — 25 idiomas da interface (.lua)
├── docs/                     — documentação por export, evento e statebag (markdown)
├── html/                     — resíduo de uma NUI antiga: não é declarado no fxmanifest nem usado pelo código
├── stream/
│   ├── [Animations]/         — dicionários de animação customizados
│   └── [Props]/              — modelos e .ytyp dos props
├── config.lua                — toda a configuração
├── custom_emotes.lua         — suas animações, preservadas entre atualizações
├── prop_dump.lua             — lista de props gerada automaticamente (whitelist de anti-cheat)
├── version.txt               — versão usada na checagem de update
└── fxmanifest.lua
```
