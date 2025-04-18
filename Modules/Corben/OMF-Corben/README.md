# Oh My Font Template
- An advanced font module template for [Magisk](https://github.com/topjohnwu/Magisk). Powered by [OMF](https://gitlab.com/nongthaihoang/oh_my_font).
- The template includes many useful variables and functions. It is designed intended mostly for font module creators.
- The template alone does nothing. You have to write your own code to make it works.
- Clone/download the repo and edit the `customize.sh`.

## Variables
**ORIGINAL Paths** @ `magisk --path`

| Variable | Value |
| - | - |
| `ORIPRDFONT` | `/product/fonts` |
| `ORIPRDETC` | `/product/etc` |
| `ORIPRDXML` | `/product/etc/fonts_customization.xml` |
| `ORISYSFONT` | `/system/fonts` |
| `ORISYSETC` | `/system/etc` |
| `ORISYSEXTETC` | `/system/system_ext/etc` |
| `ORISYSXML` | `/system/etc/fonts.xml` |

**MODULE Paths** @ `$MODPATH`

| Variable | Value |
| - | - |
| `PRDFONT` | `/system/product/fonts` |
| `PRDETC` | `/system/product/etc` |
| `PRDXML` | `/system/product/etc/fonts_customization.xml` |
| `SYSFONT` | `/system/fonts` |
| `SYSETC` | `/system/etc` |
| `SYSEXTETC` | `/system/system_ext/etc` |
| `SYSXML` | `/system/etc/fonts.xml` |
| `MODPROP` | `/module.prop` |
| `FONTS` | `/fonts` |

**FONTS** @ `fonts.xml`

| Variable | Value |
| - | - |
| `SA` | `sans-serif` |
| `SC` | `sans-serif-condensed` |
| `MO` | `monospace` |
| `SE` | `serif` |
| `SO` | `serif-monospace` |
| `SS` | Sans Serif VF |
| `SSI` | Sans Serif Italic VF |
| `SER` | Serif VF |
| `SERI` | Serif Italic VF |
| `MS` | Monospace VF |
| `MSI` | Monospace Italic VF |
| `SRM` | Serif Monospace VF |
| `SRMI` | Serif Monospace Italic VF |

**Others**

| Variable | Value |
| - | - |
| `OMFDIR` | `/sdcard/OhMyFont ` |

## Functions
**`ver`** (version)
  - Append text to the version string which shows in Magisk app.  
  - Usage: `ver <text>`

**`xml`**
  - Shortcut for the `sed` command to edit fontxml `$XML` (default is `$SYSXML`).  
  - Usage: `xml <sed expresions>`

**`src`** (source)
  - Source (execute) custom scripts (`.sh` files) in  `$OMFDIR`

**`cpf`** (copy font)
  - copy (do not overwrite) fonts from `$FONTS` to `$CPF` (default is `$SYSFONT`).
  - Usage: `cpf [<font_name> ...]`
  - E.g. `cpf font1.ttf font2.ttf font3.otf`

**`fallback`**
  - Make a font family fallback.  
  - Usage: `fallback [font_family]`  
    If no argument is provided, the font family will be `sans-serif` by default.  
  - E.g.  
    `fallback`  
    `fallback serif`  
    It recommends to call the variable `$FB` which is a shortcut for this function. `$FB` will be empty if the fontxml is already patched (i.e. Oxygen 11).

**`prep`** (prepare)
  - Copy the original fontxml `$ORIFONTXML` to module path `$SYSFONTXML` and check if it is patched. This is usually the first function you want to call.  

**`font`**
  - The most powerful function to manipulate `<font>` tag inside a fontxml.  
  - Usage: `font <font_family> <font_name> <font_style> [axis value ...]`
  - `font_family`: `sans-serif`, `serif`, `monospace`, etc  
  - `font_name`: Regular.ttf, Medium.ttf, MyFontName.ttf  
  - `font_style` (from Thin to Black)
  - Uprights: `t`, `el`, `l`, `r`, `m`, `sb`, `b`, `eb`, `bl`  
  - Italics: `ti`, `eli`, `li`, `ri`, `mi`, `sbi`, `bi`, `ebi`, `bli`  
  - `axis`: wdth, wght, slnt, opsz, etc.
  - `value`: value corresponds to each `axis`
  - E.g.  
    `font sans-serif MyFont-Regular.ttf r`  
    `font serif MyFont-Bold.ttf b`  
    `font sans-serif AnyFont-VF.ttf bl wght 900 width 100`  

**`mksty`** (make style)
  - Edit fontxml to add more font styles for a family. Only usefull if your font has more weights than default.  
  - Usage: `mksty [font_family] <max_weight> [min_weight]`  
    without any arguments, `font_family` will be `sans-serif` and `max_weigt` is 9 by default.
  - E.g.  
    `mksty`  
    will make 9 weights for `sans-serif` - both uprights and italics (18 styles). Use this if your font has full weights.  
    `mksty $SC 9`  
    does the same thing but for `sans-serif-condensed` family

**`finish`**
  - Remove all unnecessary files except folder `system` and file `module.prop`, correct permissions. Run it as the last function.  

**`config`**
  - Copy the default config file to `/sdcard/OhMyFont/config.cfg`.

**`valof`** (value of)
  - Read the value of a variable in the config file.  
  - Usage: `valof <variable>`  
  - E.g. `MyVar=$(valof MyVar)`

**`rom`**
  - Try to make the module work system-wide on a ROMs that already uses custom fonts by default. This function is only made for the `sans-serif` font family. Do NOT use it if changing any other font families. Call this function before `finish`.  

**`install_font`**
  - The main font installation fuction to install 4 main font families.

**`sans`**
  - The function to install the default `sans-serif` font family.
  - Usage: `sans <family>`
  - E.g.  
    `sans source-sans-pro` will install the default `sans-serif` font for `source-sans-pro` family.  
    `local XML=$PRDXML; sans rubik; XML=` will install the default `sans-serif` font for `rubik` family in `$PRDXML`

**`serf`**
  - The function to install the default `serif` font family.
  - Usage: `serif <family>`
  - E.g. similar to `sans`

**`mono`**
  - The function to install the default `monospace` font family.
  - Usage: `mono <family>`
  - E.g. similar to `sans`

**`srmo`**
  - The function to install the default `serif-monospace` font family.
  - Usage: `srmo <family>`
  - E.g. similar to `sans`

**`bold`**
  - A font option for `sans-serif` to replace `Regular` style with `Medium` one. It will read the `BOLD` value in the config file. Run this function after `rom`.  

## Options
| Option | Description |
| - | - |
| `SANS=false` | Do not install sans-serif |
| `SANS=serif` | Replace sans-serif with serif |
| `SANS=monospace` | Replace sans-serif with monospace |
| `SANS=serif_monospace` | Replace sans-serif with serif-monospace |
| `SERF=false` | Do not install serif |
| `SERF=sans_serif` | Replace serif with sans-serif |
| `SERF=monospace` | Replace serif with monospace |
| `SERF=serif_monospace` | Replace serif with serif-monospace |
| `MONO=false` | Do not install monospace |
| `MONO=serif_monospace` | Replace monospace with serif-monospace |
| `SRMO=false` | Do not install serif-monospace |
| `SRMO=monospace` | Replace serif-monospace with monospace |

## How to use
You can now write your own code by using the functions above. Or use the built-in functions to install custom fonts automatically.
1. Put your fonts into the `fonts` folder and name them as below:
  - Static Fonts
    - **`sans-serif`**:
      ```
      Black.ttf            or ubl.ttf
      ExtraBold.ttf        or ueb.ttf
      Bold.ttf             or ub.ttf
      SemiBold.ttf         or usb.ttf
      Medium.ttf           or um.ttf
      Regular.ttf          or ur.ttf
      Light.ttf            or ul.ttf
      ExtraLight.ttf       or uel.ttf
      Thin.ttf             or ut.ttf
  
      BlackItalic.ttf      or ibl.ttf
      ExtraBoldItalic.ttf  or ieb.ttf
      BoldItalic.ttf       or ib.ttf
      SemiBoldItalic.ttf   or isb.ttf
      MediumItalic.ttf     or im.ttf
      Italic.ttf           or ir.ttf
      LightItalic.ttf      or il.ttf
      ExtraLightItalic.ttf or iel.ttf
      ThinItalic.ttf       or it.ttf
  
      Condensed-Black.ttf            or cbl.ttf
      Condensed-ExtraBold.ttf        or ceb.ttf
      Condensed-Bold.ttf             or cb.ttf
      Condensed-SemiBold.ttf         or csb.ttf
      Condensed-Medium.ttf           or cm.ttf
      Condensed-Regular.ttf          or cr.ttf
      Condensed-Light.ttf            or cl.ttf
      Condensed-ExtraLight.ttf       or cel.ttf
      Condensed-Thin.ttf             or ct.ttf
  
      Condensed-BlackItalic.ttf      or dbl.ttf
      Condensed-ExtraBoldItalic.ttf  or deb.ttf
      Condensed-BoldItalic.ttf       or db.ttf
      Condensed-SemiBoldItalic.ttf   or dsb.ttf
      Condensed-MediumItalic.ttf     or dm.ttf
      Condensed-Italic.ttf           or dr.ttf
      Condensed-LightItalic.ttf      or dl.ttf
      Condensed-ExtraLightItalic.ttf or del.ttf
      Condensed-ThinItalic.ttf       or dt.ttf
      ```
    - **`monospace`**:
      ```
      Mono-Black.ttf            or mbl.ttf
      Mono-ExtraBold.ttf        or meb.ttf
      Mono-Bold.ttf             or mb.ttf
      Mono-SemiBold.ttf         or msb.ttf
      Mono-Medium.ttf           or mm.ttf
      Mono-Regular.ttf          or mr.ttf
      Mono-Light.ttf            or ml.ttf
      Mono-ExtraLight.ttf       or mel.ttf
      Mono-Thin.ttf             or mt.ttf
  
      Mono-BlackItalic.ttf      or nbl.ttf
      Mono-ExtraBoldItalic.ttf  or neb.ttf
      Mono-BoldItalic.ttf       or nb.ttf
      Mono-SemiBoldItalic.ttf   or nsb.ttf
      Mono-MediumItalic.ttf     or nm.ttf
      Mono-Italic.ttf           or nr.ttf
      Mono-LightItalic.ttf      or nl.ttf
      Mono-ExtraLightItalic.ttf or nel.ttf
      Mono-ThinItalic.ttf       or nt.ttf
      ```
    - **`serif`**:
      ```
      Serif-Black.ttf            or sbl.ttf
      Serif-ExtraBold.ttf        or seb.ttf
      Serif-Bold.ttf             or sb.ttf
      Serif-SemiBold.ttf         or ssb.ttf
      Serif-Medium.ttf           or sm.ttf
      Serif-Regular.ttf          or sr.ttf
      Serif-Light.ttf            or sl.ttf
      Serif-ExtraLight.ttf       or sel.ttf
      Serif-Thin.ttf             or st.ttf
  
      Serif-BlackItalic.ttf      or tbl.ttf
      Serif-ExtraBoldItalic.ttf  or teb.ttf
      Serif-BoldItalic.ttf       or tb.ttf
      Serif-SemiBoldItalic.ttf   or tsb.ttf
      Serif-MediumItalic.ttf     or tm.ttf
      Serif-Italic.ttf           or tr.ttf
      Serif-LightItalic.ttf      or tl.ttf
      Serif-ExtraLightItalic.ttf or tel.ttf
      Serif-ThinItalic.ttf       or tt.ttf
      ```
    - **`serif-monospace`**:
      ```
      SerifMono-Black.ttf            or obl.ttf
      SerifMono-ExtraBold.ttf        or oeb.ttf
      SerifMono-Bold.ttf             or ob.ttf
      SerifMono-SemiBold.ttf         or osb.ttf
      SerifMono-Medium.ttf           or om.ttf
      SerifMono-Regular.ttf          or or.ttf
      SerifMono-Light.ttf            or ol.ttf
      SerifMono-ExtraLight.ttf       or oel.ttf
      SerifMono-Thin.ttf             or ot.ttf
  
      SerifMono-BlackItalic.ttf      or pbl.ttf
      SerifMono-ExtraBoldItalic.ttf  or peb.ttf
      SerifMono-BoldItalic.ttf       or pb.ttf
      SerifMono-SemiBoldItalic.ttf   or psb.ttf
      SerifMono-MediumItalic.ttf     or pm.ttf
      SerifMono-Italic.ttf           or pr.ttf
      SerifMono-LightItalic.ttf      or pl.ttf
      SerifMono-ExtraLightItalic.ttf or pel.ttf
      SerifMono-ThinItalic.ttf       or pt.ttf
      ```
  - Variable Fonts (VF)  
    At the bottom of the config file (config.cfg), you will see many empty variables. Uncomment and assign values for them:
    - **`sans-serif`**:
      ```
      SS=<upright_font>
      e.g. SS=MyFont.ttf
      SSI=<italic_font>
      e.g. SSI=MyFont-Italic.ttf
      ```
    - **`monospace`**:
      ```
      MS=<upright_font>
      e.g. MS=MyFontMono.ttf
      MSI=<italic_font>
      e.g. MSI=MyFontMono-Italic.ttf
      ```
    - **`serif`**:
      ```
      SER=<upright_font>
      e.g. SER=MyFontSerif.ttf
      SERI=<italic_font>
      e.g. SERI=MyFontSerif-Italic.ttf
      ```
    - **`serif-monospace`**:
      ```
      SRM=<upright_font>
      e.g. SER=MyFontSerifMono.ttf
      SRMI=<italic_font>
      e.g. SRMI=MyFontSerifMono-Italic.ttf
      ```
2. (Only for VF) Configuring axes follows this diagram:
  ```
  U, I, C, D are 4 styles of sans-serif

                          Weights
                    +-----------------+
       Fonts        | T  | Thin       |
  +---------------+ | EL | ExtraLight |
  | U | Upright   | | L  | Light      |
  | I | Italic    | | R  | Regular    |
  | C | Condensed | | M  | Medium     |
  | D | CI        | | SB | SemiBold   |
  | M | Monospace | | B  | Bold       |
  | S | Serif     | | EB | ExtraBold  |
  | O | SM        | | BL | Black      |
  +---------------+ +-----------------+
     |                 |
     |       +---------+
     |       |
   ------ -------
   <font><weight>
   -------------- 
         |
      +--+
      |
   -------
   <style> = [<axis> <value> ...]

  e.g   UR = wght 400
        UB = wght 700
  ```
3. Open the `customize.sh`, uncomment the commented codes.
### Note
- For each font family, there must be at least one Regular font, the rest are optional.

## Support
- [Telegram](https://t.me/ohmyfont)
