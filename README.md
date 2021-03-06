# readme2tex
Renders LaTeX for Github Readmes

<p align="center"><img alt="$$&#10;\huge\text{Hello \LaTeX}&#10;$$" src="svgs/d27ecd9d6334c7a020001926c8000801.png?invert_in_darkmode&sanitize=true" align=middle width="160.1989356pt" height="31.01420355pt"/></p>

<p align="center"><img alt="\begin{tikzpicture}&#10;\newcounter{density}&#10;\setcounter{density}{20}&#10;    \def\couleur{blue}&#10;    \path[coordinate] (0,0)  coordinate(A)&#10;                ++( 60:6cm) coordinate(B)&#10;                ++(-60:6cm) coordinate(C);&#10;    \draw[fill=\couleur!\thedensity] (A) -- (B) -- (C) -- cycle;&#10;    \foreach \x in {1,...,15}{%&#10;        \pgfmathsetcounter{density}{\thedensity+10}&#10;        \setcounter{density}{\thedensity}&#10;        \path[coordinate] coordinate(X) at (A){};&#10;        \path[coordinate] (A) -- (B) coordinate[pos=.15](A)&#10;                            -- (C) coordinate[pos=.15](B)&#10;                            -- (X) coordinate[pos=.15](C);&#10;        \draw[fill=\couleur!\thedensity] (A)--(B)--(C)--cycle;&#10;    }&#10;\end{tikzpicture}" src="svgs/a00f34be6b1ce8e4820c9852c5e6163e.png?sanitize=true" align=middle width="281.28567885pt" height="243.69095025pt"/></p>

<sub>**Make sure that pdflatex is installed on your system.**</sub>

----------------------------------------

`readme2tex` is a Python script that "texifies" your readme. It takes in Github Markdown and
replaces anything enclosed between dollar signs with rendered <img alt="$\text{\LaTeX}$" src="svgs/c068b57af6b6fa949824f73dcb828783.png?invert_in_darkmode&sanitize=true" align=middle width="42.18690795pt" height="22.4657235pt"/>.

In addition, while other Github TeX renderers tend to give a jumpy look to the compiled text, 
<p align="center">
<img src="http://i.imgur.com/XSV1rPw.png?1" width=500/>
</p>

`readme2tex` ensures that inline mathematical expressions
are properly aligned with the rest of the text to give a more natural look to the document. For example,
this formula <img alt="$\frac{dy}{dx}$" src="svgs/24a7d013bfb0af0838f476055fc6e1ef.png?invert_in_darkmode&sanitize=true" align=middle width="14.29744965pt" height="30.648288pt"/> is preprocessed so that it lines up at the correct baseline for the text.
This is the one salient feature of this package compared to the others out there.

### Dependencies

* [Python 2.7](https://www.python.org/) -- The sourcecode for readme2tex is written in Python, so Python is required to compile readme2tex from source.
    * Install the following packages with python packages`pip install [PACKAGE NAME]`
    
        * `pip install [cairosvg](https://cairosvg.org/)` -- Required to convert SVG impages to PNG. CairoSVG requires the [pycairo graphics pacakage](https://www.cairographics.org/pycairo/). Follow [these instructions](https://www.cairographics.org/download/) to install. 
        
        **On Windows:** The Cairo project does not provide pre-compiled binaries for Windows, but Christoph Gohlke maintains a site containing unofficial Windows binaries for several Python extension packages, including Cairo itself. Therefore, the easiest way to install Cairo on Windows along with its Python bindings is simply to download it from [Christoph’s site](http://www.lfd.uci.edu/~gohlke/pythonlibs/#pycairo). Make sure you use an installer that is suitable for your Windows platform (32-bit or 64-bit) and the version of Python you are using.
        
* [LaTeX](https://www.latex-project.org/) -- A language for writing Mathematical equations. [MiKTEX](https://miktex.org/) is the prefered Latex software for Windows. 
    * Ensure `latex` and `dvisvgm` on your `PATH`. 
    * Pre-install the following packages in $\text{\LaTeX}$.
        * `geometry`
        * `tkiz`
        * `ms`
        * `xclolor`
* [Microsoft Visual C++ 9.0](http://aka.ms/vcpython27) is required to compile readme2tex from source.
    
### Installation
To install `readme2tex`, you'll need to run

```bash
git clone https://github.com/NEU-ABLE-LAB/readme2tex.git
cd readme2tex
python setup.py develop
```

To compile `INPUT.md` and render all of its formulas, run

```bash
python -m readme2tex --output README.md INPUT.md
```

If you want to do this automatically for every commit of INPUT.md, you can add the git post-commit hook found and instructions in the `hooks/` directory. Every `git commit` that touches `*.texmd` from now on will allow you to automatically run `readme2tex` on it, saving you from having to remember how `readme2tex` works. The caveat is that if you use a GUI to interact with git, things might get a bit wonky. In particular, `readme2tex` will just assume that you're fine with all of the changes and won't prompt you for verification like it does on the terminal.

<p align="center">
<a href="https://asciinema.org/a/2am62r2x2udg1zqyb6r3kpm1i"><img src="https://asciinema.org/a/2am62r2x2udg1zqyb6r3kpm1i.png" width=600/></a>
</p>

See `python -m readme2tex --help` for a list of what you can do in `readme2tex`.

### Examples:

Here's a display level formula
<p align="center"><img alt="$$&#10;\frac{n!}{k!(n-k)!} = {n \choose k}&#10;$$" src="svgs/32737e0a8d5a4cf32ba3ab1b74902ab7.png?invert_in_darkmode&sanitize=true" align=middle width="127.9847844pt" height="39.45245535pt"/></p>

The code that was used to render this formula is just

    $$
    \frac{n!}{k!(n-k)!} = {n \choose k}
    $$

<sub>*Note: you can escape \$ so that they don't render.*</sub>

Here's an inline formula. 

> It is well known that if <img alt="$ax^2 + bx + c =0$" src="svgs/162f63774d8a882cc15ae1301cfd8ac0.png?invert_in_darkmode&sanitize=true" align=middle width="119.34141285pt" height="26.7617526pt"/>, then <img alt="$x = \frac{-b \pm \sqrt{b^2- 4ac}}{2a}$" src="svgs/584fa2612b78129d140fb208e9d76ae9.png?invert_in_darkmode&sanitize=true" align=middle width="112.44128445pt" height="33.205392pt"/>.

The code that was used to render this is:

    It is well known that if $ax^2 + bx + c = 0$, then $x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$.

Notice that the formulas line up with the baseline of the text, even when the height of these two images are different.

Sometimes, you might run into formulas that are bottom-heavy, like <img alt="$x^2\sum\limits_{3^{n^{n^{n}}}}$" src="svgs/4cb4ead947a07837121937c807973436.png?invert_in_darkmode&sanitize=true" align=middle width="47.78004pt" height="37.0321017pt"/>. Here, `readme2tex`
can compute the correct offset to align this formula to the baseline of your paragraph of text as well.

#### Tikz (Courtesy of http://www.texample.net/)

Did you notice the picture at the top of this page? That was also generated by <img alt="$\text{\LaTeX}$" src="svgs/c068b57af6b6fa949824f73dcb828783.png?invert_in_darkmode&sanitize=true" align=middle width="42.18690795pt" height="22.4657235pt"/>. `readme2tex` is capable of
handling Tikz code. For reference, the picture

<p align="center"><img alt="\begin{tikzpicture}&#10;\newcounter{density}&#10;\setcounter{density}{20}&#10;    \def\couleur{red}&#10;    \path[coordinate] (0,0)  coordinate(A)&#10;                ++( 60:6cm) coordinate(B)&#10;                ++(-60:6cm) coordinate(C);&#10;    \draw[fill=\couleur!\thedensity] (A) -- (B) -- (C) -- cycle;&#10;    \foreach \x in {1,...,15}{%&#10;        \pgfmathsetcounter{density}{\thedensity+10}&#10;        \setcounter{density}{\thedensity}&#10;        \path[coordinate] coordinate(X) at (A){};&#10;        \path[coordinate] (A) -- (B) coordinate[pos=.15](A)&#10;                            -- (C) coordinate[pos=.15](B)&#10;                            -- (X) coordinate[pos=.15](C);&#10;        \draw[fill=\couleur!\thedensity] (A)--(B)--(C)--cycle;&#10;    }&#10;\end{tikzpicture}" src="svgs/522cbfbc866df378cb95b2ef083131b2.png?sanitize=true" align=middle width="281.28567885pt" height="243.69095025pt"/></p>

is given by the tikz code

    \begin{tikzpicture}
    \newcounter{density}
    \setcounter{density}{20}
        \def\couleur{red}
        \path[coordinate] (0,0)  coordinate(A)
                    ++( 60:6cm) coordinate(B)
                    ++(-60:6cm) coordinate(C);
        \draw[fill=\couleur!\thedensity] (A) -- (B) -- (C) -- cycle;
        \foreach \x in {1,...,15}{%
            \pgfmathsetcounter{density}{\thedensity+10}
            \setcounter{density}{\thedensity}
            \path[coordinate] coordinate(X) at (A){};
            \path[coordinate] (A) -- (B) coordinate[pos=.15](A)
                                -- (C) coordinate[pos=.15](B)
                                -- (X) coordinate[pos=.15](C);
            \draw[fill=\couleur!\thedensity] (A)--(B)--(C)--cycle;
        }
    \end{tikzpicture}

We can see a few other examples, such as this graphical proof of the Pythagorean Theorem.

<p align="center"><img alt="\begin{tikzpicture}&#10;\newcommand{\pythagwidth}{3cm}&#10;\newcommand{\pythagheight}{2cm}&#10;  \coordinate [label={below right:$A$}] (A) at (0, 0);&#10;  \coordinate [label={above right:$B$}] (B) at (0, \pythagheight);&#10;  \coordinate [label={below left:$C$}] (C) at (-\pythagwidth, 0);&#10;&#10;  \coordinate (D1) at (-\pythagheight, \pythagheight + \pythagwidth);&#10;  \coordinate (D2) at (-\pythagheight - \pythagwidth, \pythagwidth);&#10;&#10;  \draw [very thick] (A) -- (C) -- (B) -- (A);&#10;&#10;  \newcommand{\ranglesize}{0.3cm}&#10;  \draw (A) -- ++ (0, \ranglesize) -- ++ (-\ranglesize, 0) -- ++ (0, -\ranglesize);&#10;&#10;  \draw [dashed] (A) -- node [below] {$b$} ++ (-\pythagwidth, 0)&#10;            -- node [right] {$b$} ++ (0, -\pythagwidth)&#10;            -- node [above] {$b$} ++ (\pythagwidth, 0)&#10;            -- node [left]  {$b$} ++ (0, \pythagwidth);&#10;&#10;  \draw [dashed] (A) -- node [right] {$c$} ++ (0, \pythagheight)&#10;            -- node [below] {$c$} ++ (\pythagheight, 0)&#10;            -- node [left]  {$c$} ++ (0, -\pythagheight)&#10;            -- node [above] {$c$} ++ (-\pythagheight, 0);&#10;&#10;  \draw [dashed] (C) -- node [above left]  {$a$} (B)&#10;                     -- node [below left]  {$a$} (D1)&#10;                     -- node [below right] {$a$} (D2)&#10;                     -- node [above right] {$a$} (C);&#10;\end{tikzpicture}" src="svgs/e148d2d3bb31215788cc03f9b472e5ba.png?invert_in_darkmode&sanitize=true" align=middle width="328.066695pt" height="374.833305pt"/></p>

How about a few snowflakes?

<p align="center"><img alt="\begin{center}&#10;\usetikzlibrary{lindenmayersystems}&#10;&#10;\pgfdeclarelindenmayersystem{A}{&#10;    \rule{F -&gt; FF[+F][-F]}&#10;}&#10;&#10;\pgfdeclarelindenmayersystem{B}{&#10;    \rule{F -&gt; ffF[++FF][--FF]}&#10;}&#10;&#10;\pgfdeclarelindenmayersystem{C}{&#10;    \symbol{G}{\pgflsystemdrawforward}&#10;    \rule{F -&gt; F[+F][-F]FG[+F][-F]FG}&#10;}&#10;&#10;\pgfdeclarelindenmayersystem{D}{&#10;    \symbol{G}{\pgflsystemdrawforward}&#10;    \symbol{H}{\pgflsystemdrawforward}&#10;    \rule{F -&gt; H[+HG][-HG]G}&#10;    \rule{G -&gt; HF}&#10;}&#10;&#10;\tikzset{&#10;    type/.style={l-system={#1, axiom=F,order=3,step=4pt,angle=60},&#10;      blue, opacity=0.4, line width=.5mm, line cap=round   &#10;    },&#10;}&#10;&#10;\newcommand\drawsnowflake[2][scale=0.2]{&#10;    \tikz[#1]&#10;    \foreach \a in {0,60,...,300}  {&#10;    \draw[rotate=\a,#2] l-system;&#10;    };&#10;}&#10;&#10;\foreach \width in {.2,.4,...,.8} &#10;{  \drawsnowflake[scale=0.3]{type=A, line width=\width mm} }&#10;&#10;\foreach \width in {.2,.4,...,.8} &#10;{  \drawsnowflake[scale=0.38]{type=A, l-system={angle=90}, line width=\width mm} }    &#10;&#10;\foreach \width in {.2,.4,...,.8} &#10;{  \drawsnowflake[scale=0.3]{type=B, line width=\width mm} }&#10;&#10;\foreach \width in {.2,.4,...,.8} &#10;{  \drawsnowflake{type=B, l-system={angle=30}, line width=\width mm} }&#10;&#10;\drawsnowflake[scale=0.24]{type=C, l-system={order=2}, line width=0.2mm}&#10;\drawsnowflake[scale=0.25]{type=C, l-system={order=2}, line width=0.4mm}&#10;\drawsnowflake[scale=0.25]{type=C, l-system={order=2,axiom=fF}, line width=0.2mm}&#10;\drawsnowflake[scale=0.32]{type=C, l-system={order=2,axiom=---fff+++F}, line width=0.2mm}&#10;&#10;\drawsnowflake[scale=0.38]{type=D, l-system={order=4,angle=60,axiom=GF}, line width=0.7mm}&#10;\drawsnowflake[scale=0.38]{type=D, l-system={order=4,angle=60,axiom=GfF}, line width=0.7mm}&#10;\drawsnowflake[scale=0.38]{type=D, l-system={order=4,angle=60,axiom=FG}, line width=0.7mm}&#10;\drawsnowflake[scale=0.38]{type=D, l-system={order=4,angle=60,axiom=FfG}, line width=0.7mm}&#10;\end{center}" src="svgs/eb57748cb91d08bfc997b0d70f7f2774.png?invert_in_darkmode&sanitize=true" align=middle width="284.69298pt" height="343.27901025pt"/></p>

### Usage

    python -m readme2tex --output README.md [READOTHER.md]

It will then look for a file called `readother.md` and compile it down to a readable Github-ready
document.

In addition, you can specify other arguments to `render.py`, such as:

* `--readme READOTHER.md` The raw readme to process. Defaults to `READOTHER.md`.
* `--output README.md` The processed readme.md file. Defaults to `README_GH.md`.
* `--usepackage tikz` Addition packages to use during <img alt="$\text{\LaTeX}$" src="svgs/c068b57af6b6fa949824f73dcb828783.png?invert_in_darkmode&sanitize=true" align=middle width="42.18690795pt" height="22.4657235pt"/> compilation. You can specify this multiple times.
* `--svgdir svgs/` The directory to store the output svgs. The default is `svgs/`
* `--branch master` *Experimental* Which branch to store the svgs into, the default is just master.
* `--username username` Your github username. This is optional, and `render.py` will try to infer this for you.
* `--project project` The current github project. This is also optional.
* `--nocdn` Ticking this will use relative paths for the output images. Defaults to False.
* `--htmlize` Ticking this will output a `md.html` file so you can preview what the output looks like. Defaults to False.
* `--valign` Ticking this will use the `valign` trick (detailed below) instead. See the caveats section for tradeoffs.
* `--rerender` Ticking this will force a recompilation of all <img alt="$\text{\LaTeX}$" src="svgs/c068b57af6b6fa949824f73dcb828783.png?invert_in_darkmode&sanitize=true" align=middle width="42.18690795pt" height="22.4657235pt"/> formulas even if they are already cached.
* `--bustcache` Ticking this will ensure that Github renews its image cache. Github may sometimes take up to an hour for changed images to reappear. This is usually not necessary unless you've made stylistic changes.
* `--add-git-hook` Ticking this will generate a post-commit hook for git that runs readme2tex with the rest of the specified arguments after each `git commit`.
* `--pngtrick` Ticking this will generate `png` files instead of `svgs` for the formulas.

My usual workflow is to create a secondary branch just for the compiled svgs. You can accomplish this via

    python -m readme2tex --branch svgs --output README.md

However, be careful with this command, since it will switch over to the `svgs` branch without any input from you.

#### Relative Paths

If you're on a private repository or you want to, for whatever reason, use relative paths to resolve your images, you can
do so by using the combination

    python -m readme2tex --branch master --nocdn --pngtrick ...

which will output `pngs` relative to your `README.md`.

Due to security considerations, Github will not resolve `svgs` relatively, which means that private repositories will
be locked out of the usual `svg` workflow. Using the `--branch master --nocdn --pngtrick` combination will get around
this restriction.

### Troubleshooting

#### Tikz

If your Tikz drawings don't show up, there's a good chance that you either don't have Ghostscript installed or
`dvisvgm` isn't picking it up for whatever reason. This is most likely to happen on some installations of TexLive
on OSX.

Check to see if `ps` is included in the list when you run

```bash
# dvisvgm -l
bgcolor    background color special
color      complete support of color specials
dvisvgm    special set for embedding raw SVG snippets
em         line drawing statements of the emTeX special set
html       hyperref specials
pdf        pdfTeX font map specials
ps         dvips PostScript specials <<<
tpic       TPIC specials
```

If not, try installing it (either `apt-get`, `yum`, or `brew`). Furthermore, if you are on OSX, make sure to add the
following to your `~/.bash_profile`

```bash
export LIBGS=/usr/local/lib/libgs.dylib
```

where `/usr/local/lib/libgs.dylib` is the location where `libgs.dylib` is installed.

#### I'm seeing weird formatting from time to time.

Make sure that if you have a `<p>...</p>` tag somewhere, you leave at least one blank line after the closing tag.

#### I ran `--add-git-hook`, but the post-commit hook isn't running after committing.

```bash
chmod +x .git/hooks/post-commit
```

#### I ran `readme2tex` and got a traceback somewhere.

Unfortunately, this script still has a few kinks and bugs that I need to iron out. In the mean time, if the `pypi` releases
aren't working for you, you should switch over to the development version to see if the bugs have been squashed:

```bash
git clone https://github.com/leegao/readme2tex
cd readme2tex
python setup.py develop
```

### Technical Tricks

#### How can you tell where the baseline of an image is?

By prepending every inline formula with an anchor. During post-processing, we can isolate the anchor, which
is fixed at the baseline, and crop it out. It's super clowny, but it does the job.

#### Caveats

Github does not allow you to pass in custom style attributes to your images. While this is useful for security purposes,
it makes it incredibly difficult to ensure that images will align correctly to the text. `readme2tex` circumvents this
using one of two tricks:

1. In Chrome, the attribute `valign=offset` works for `img` tags as well. This allows us to shift the image directly.
Unfortunately, this is not supported within any of the other major browsers, therefore this mode is not enabled by
default.
2. In every (reasonably modern) browser, the `align=middle` attribute will vertically center an image. However, the
definition of the vertical "center" is different. In particular, for Chrome, Firefox, (and probably Safari), that center
is the exact middle of the image. For IE and Edge however, the center is about 5 pixels (the height of a lower-case character)
above the exact center. Since this looks great for non-IE browsers, and reasonably good on Edge, this is the default
rendering method. The trick here is to pad either the top or the bottom of the image with extra spaces until the
baseline of the formula is at the center. For most formulas, this works great. However, if you have a tall formula,
like <img alt="$\frac{~}{\sum\limits_{x^{x^{x^{x}}}}^{x^{x^{x^{x}}}} f(x)}$" src="svgs/bdd0f9b91b7fff7fe5a2b1b7684a96ef.png?invert_in_darkmode&sanitize=true" align=middle width="56.16663525pt" height="71.6896521pt"/>, you'll notice that there might be a lot
of slack vertical spacing between these lines. If this is a deal-breaker for you, you can always try the `--valign True`
mode. For most inline formulas, this is usually a non-issue.

#### How to compile this document
Make sure that you have the `tikz` and the `xcolor` packages installed locally.

    python -m readme2tex --usepackage "tikz" --usepackage "xcolor" --output README.md --nocdn

For the `png` relative mode, use

    python -m readme2tex --usepackage "tikz" --usepackage "xcolor" --output README.md --branch master --nocdn --pngtrick

----------------------------------------

<p align="center"><img alt="\begin{tikzpicture}[scale=0.25, line join=bevel]&#10;% \a and \b are two macros defining characteristic&#10;% dimensions of the Penrose triangle.&#9;&#9;&#10;\pgfmathsetmacro{\a}{2.5}&#10;\pgfmathsetmacro{\b}{0.9}&#10;&#10;\tikzset{%&#10;  apply style/.code     = {\tikzset{#1}},&#10;  triangle_edges/.style = {thick,draw=black}&#10;}&#10;&#10;\foreach \theta/\facestyle in {%&#10;    0/{triangle_edges, fill = gray!50},&#10;  120/{triangle_edges, fill = gray!25},&#10;  240/{triangle_edges, fill = gray!90}%&#10;}{&#10;  \begin{scope}[rotate=\theta]&#10;    \draw[apply style/.expand once=\facestyle]&#10;      ({-sqrt(3)/2*\a},{-0.5*\a})                     --&#10;      ++(-\b,0)                                       --&#10;        ({0.5*\b},{\a+3*sqrt(3)/2*\b})                -- % higher point&#9;&#10;        ({sqrt(3)/2*\a+2.5*\b},{-.5*\a-sqrt(3)/2*\b}) -- % rightmost point&#10;      ++({-.5*\b},-{sqrt(3)/2*\b})                    -- % lower point&#10;        ({0.5*\b},{\a+sqrt(3)/2*\b})                  --&#10;      cycle;&#10;    \end{scope}&#10;  }&#9;&#10;\end{tikzpicture}" src="svgs/48ab6ba0b4263d6ecddedfd213f66ff5.png?invert_in_darkmode&sanitize=true" align=middle width="104.5626615pt" height="90.7308765pt"/></p>

# TODO
[] Re-implement `--add-git-hook`
[] Confirm that the texmd2md git hook works recursively
[] Robustly test texmd2md git hook