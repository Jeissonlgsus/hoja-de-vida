\ProvidesClass{twentysecondcv}[2015/02/28 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
%	 REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{ClearSans}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}

\usepackage{enumitem}
\setlist[itemize]{leftmargin=*}

\RequirePackage[hidelinks]{hyperref}
\hypersetup{
    pdftitle={},
    pdfauthor={},
    pdfsubject={},
    pdfkeywords={},
    colorlinks=false,           % no lik border color
    allbordercolors=white       % white border color for all
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\ifxetex
  \usepackage{letltxmacro}
  \setlength{\XeTeXLinkMargin}{1pt}
  \LetLtxMacro\SavedIncludeGraphics\includegraphics
  \def\includegraphics#1#{% #1 catches optional stuff (star/opt. arg.)
    \IncludeGraphicsAux{#1}%
  }%
  \newcommand*{\IncludeGraphicsAux}[2]{%
    \XeTeXLinkBox{%
      \SavedIncludeGraphics#1{#2}%
    }%
  }%
\fi

%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{mainblue}{HTML}{753742}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{mainRed}{RGB}{146,0,0}
\definecolor{secondRed}{RGB}{200,0,0}

\definecolor{pblue}{HTML}{0395DE}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}
\definecolor{pblue}{HTML}{0395DE}
\definecolor{materialpurple}{HTML}{9C27B0}
\definecolor{materialindigo}{HTML}{3F51B5}
\definecolor{materialblue}{HTML}{2196F3}
\definecolor{materialcyan}{HTML}{00BCD4}
\definecolor{materialteal}{HTML}{009688}
\definecolor{materialgreen}{HTML}{4CAF50}
\definecolor{materiallime}{HTML}{CDDC39}
\definecolor{materialamber}{HTML}{FFC107}
\definecolor{materialbrown}{HTML}{795548}
\definecolor{materialred}{HTML}{FF4436}
\definecolor{materialorange}{HTML}{FF5722}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

% \renewcommand{\bfseries}{\color{black}} % Make \textbf produce coloured text instead

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

% --------------------------------------------------------------------------------------
% 	FONTS
%-------------------------------------------------------------------------------------
\newfontfamily\headingfont[Path = fonts/]{segoeuib.ttf}

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newcommand{\profilesection}[2]{\vspace{8pt}{\color{black!80} \huge #1 \rule[0.15\baselineskip]{#2}{1pt}}}

% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}}

% Command for printing skill progress bars


% Command for printing skill progress bars
\newcommand\interests[1]{ 
	\renewcommand{\interests}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (6,\i+0.4);
				\draw[fill=white,mainRed](0,\i) rectangle (\y,\i+0.4);
				\node [above right] at (0,\i+0.4) {\x};
			}
		\end{tikzpicture}
	}
}
\newcommand\hobbies[1]{ 
	\renewcommand{\hobbies}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (6,\i+0.4);
				\draw[fill=white,secondRed](0,\i) rectangle (\y,\i+0.4);
				\node [above right] at (0,\i+0.4) {\x};
			}
		\end{tikzpicture}
	}
}

%----------------------------------------------------------------------------------------
%  SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makeprofile}{
  \begin{tikzpicture}[remember picture,overlay]
      \node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
  \end{tikzpicture}

  %------------------------------------------------

  \begin{textblock}{6}(0.5, 0.2)

    %------------------------------------------------
    
        \vspace{4mm}
    {\Huge\color{mainRed}\cvname}

    %------------------------------------------------
    
    {\Large\color{black!80}\cvjobtitle}

    %------------------------------------------------
    
        \vspace{5mm}
    \renewcommand{\arraystretch}{1.6}
    \begin{tabular}{p{1cm} @{\hskip 0.5cm}p{5cm}}
        
          \ifthenelse{\equal{\cvlinkedin}{}}{}{
            {$
              \begin{array}{l}
              {\href{\cvlinkedin}{\includegraphics[scale=0.04]{img/LinkedIn_Logo.png}}}
              \end{array}
              $} & \href{\cvlinkedin}{\hspace{16mm} Jeisson Sánchez} \\
            }
      \ifthenelse{\equal{\cvnumberphone}{}}{}{
            {$
              \begin{array}{l}
              \includegraphics[scale=0.1]{img/tel.png}
              \end{array}
              $} 
            & \cvnumberphone\\}
      \ifthenelse{\equal{\href{\cvsite}{\cvsite}}{}}{}{
            {$
              \begin{array}{l}
              {\href{\cvsite}{\includegraphics[scale=0.11]{img/globe-512.png}}}
              \end{array}
              $} 
            & \cvsite\\}
      \ifthenelse{\equal{\cvmail}{}}{}{
            {$
              \begin{array}{l}
              {\href{mailto:\cvmail}{\includegraphics[scale=0.05]{img/email.png}}}
              \end{array}
              $} 
            & \href{mailto:\cvmail}{\cvmail}}
    \end{tabular}
    %------------------------------------------------

        
        %------------------------------------------------
        
        \profilesection{Lenguajes}{3cm} 
        
		\interests{{Javascript /5},{HTML/5},{CSS/5},{Python/4},{React JS/5},{Latex/5},{Typescript/4},{Redux toolkit/3},{Storybook/3},{Material UI/3},{React Router Dom /5}}
        
        \interests
        
        \profilesection{Hobbies}{3cm} 

        \hobbies{{Pintura /5},{Música/5.4},{Deporte/4},{Escritura/5}}

        \hobbies
        
    
      \end{textblock}
    }


%----------------------------------------------------------------------------------------
%	 COLOURED SECTION TITLE BOX
%----------------------------------------------------------------------------------------

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[2]{%
	\tikz[baseline=(char.base)]\node[anchor=north west, draw,rectangle, rounded corners, inner sep=1.6pt, minimum size=5.5mm, text height=3.6mm, fill=#2,#2,text=white](char){#1};%
}

\def\@sectioncolor#1#2#3{%
	{%
		\color{mainRed} #1#2#3%
	}%
}


\renewcommand{\section}[1]{
  \par\vspace{\parskip}
	{%
		\LARGE\headingfont\color{headercolor}%
		\@sectioncolor #1%
	}
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{%
		\Large\headingfont\color{headercolor} #1%
	}
	\par\vspace{.25\parskip}%
}

\pagestyle{empty}

%----------------------------------------------------------------------------------------
%	 LONG LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the long list
\newenvironment{twenty}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\twentyitem}[5]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{#2}% 
		\hfill%
		{\footnotesize#3}\\%
        \ifblank{#4}{}{#4 \\}
		#5\vspace{\parsep}%
	}\\
}

%----------------------------------------------------------------------------------------
%	 SMALL LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the small list
\newenvironment{twentyshort}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\twentyitemshort}[2]{%
	#1&\parbox[t]{0.83\textwidth}{%
		#2%
	}\\
}

%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}




