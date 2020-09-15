# PINKIE THEME
# ============
#
# BASED ON THE BEAUTIFUL TRANS FLAG

evaluate-commands %sh{
    text="rgb:0000cc"
    lavendar="rgb:e296ff"
    lavendar_bg="rgb:efedff"
    purple="rgb:8c19ff"
    purple_bg="rgb:d4daff"
    blue_bg="rgb:cceeff"
    dark_pink="rgb:e300db"
    pink="rgb:ed8cda"
    pink_bg="rgb:ffd2ff"
    cyan_text="rgb:4998de"
    # from reeder
    white="rgb:f9f8f6"
    # ???
    black="rgb:383838"

    # Base color definitions
    echo "
        # REEDER
        # THESE LOOK FUN
        face global variable   ${lavendar}+u
        face global module     ${purple}
        face global function   default+i
        face global builtin    default+b
        # INK
        face global value      default,${blue_bg}
        face global type       ${dark_pink}
        face global identifier ${purple}
        face global string     default,${pink_bg}
        # ????
        face global error      rgb:a60a3b+b
        face global keyword    rgb:3287ff+b
        face global operator   rgb:212121
        face global attribute  ${purple}+u
        face global comment    ${cyan_text}
        face global meta       ${pink}


        # and markup
        face global title      ${purple}+b
        face global header     ${lavendar}+b
        face global bold       default+b
        face global italic     default+i
        face global mono       default,${pink_bg}
        face global block      default,${pink_bg}
        # ???
        face global link       rgb:ffffff
        face global bullet     ${purple}+b
        face global list       rgb:ffffff

        # and built in faces
        face global Default            ${text},${white}
        face global PrimarySelection   default,${purple_bg}
        face global SecondarySelection ${text},${lavendar_bg}+fga
        face global PrimaryCursor      ${text},rgb:b6a5f2+fg
        face global SecondaryCursor    ${text},rgb:c2bbfc+fga
        face global PrimaryCursorEol   ${text},${dark_pink}+fg
        face global SecondaryCursorEol ${text},${pink}+fg
        face global LineNumbers        ${cyan_text}
        face global LineNumberCursor   ${text},${blue_bg}
        face global MenuForeground     ${text},${pink_bg}
        face global MenuBackground     ${text},${blue_bg}
        face global MenuInfo           default,${black}
        face global Information        ${text},${lavendar_bg}
        face global Error              ${text},${pink_bg}
        face global StatusLine         ${text},${lavendar_bg}
        face global StatusLineMode     ${text},${pink_bg}
        face global StatusLineInfo     ${text}+b
        face global StatusLineValue    ${dark_pink}
        face global StatusCursor       ${dark_pink},${white}
        face global Prompt             ${text},${pink_bg}
        face global MatchingChar       ${lavendar}+b
        face global BufferPadding      ${cyan_text},${white}
        face global Whitespace         ${cyan_text}+f
    "
}
