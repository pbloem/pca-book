\NeedsTeXFormat{LaTeX2e} % [1995/12/01]

\ProvidesClass{pca}[2023/06/18 LaTeX class for book on PCA]

%%% Load the report class as a base %%%
\LoadClass[10pt,twoside,openright]{book}

\RequirePackage[paperwidth=6.14in,paperheight=9.21in,headsep=13.5pt]{geometry}
\geometry{right=81pt, left=81pt}


%%% General packages required %%%
\RequirePackage{calc}

% the main font
\RequirePackage{charter}

%%% Style the headers
\RequirePackage{fancyhdr}
\RequirePackage{color}
\RequirePackage{xcolor}
\RequirePackage{titlesec}
%\RequirePackage{etoolbox}
%\RequirePackage[fontsize=10pt,baseline=13.5pt,lines=38]{grid}

%\RequirePackage{noindentafter}
%
%%\NoIndentAfterEnv{summary}
%\NoIndentAfterEnv{figure}
%\NoIndentAfterEnv{aside}
%\NoIndentAfterEnv{align*}
%\NoIndentAfterEnv{proof}
%\NoIndentAfterEnv{theorem}
%\NoIndentAfterEnv{lemma}
%%\NoIndentAfterEnv{example}
%%\NoIndentAfterEnv{definition}
%\NoIndentAfterEnv{itemize}
%\NoIndentAfterEnv{enumerate}
%%\NoIndentAfterEnv{description}
%\NoIndentAfterEnv{displayquote}
%\NoIndentAfterCmd{\]}


% this is needed for fancyhdr to work
\setlength{\headheight}{15.2pt}
% define the 'fancy' page style
%% call once to set up the defaults
\pagestyle{fancy}
%% What to put in the boxes
\fancyhead[EL]{{\fontfamily{bch}\selectfont\makebox[25pt][l]{\thepage}\leftmark}} % 2pt hack to fix a weird bug
\fancyhead[OR]{{\fontfamily{bch}\selectfont\rightmark\makebox[27pt][r]{\thepage}}}
\fancyhead[OL]{}
\fancyhead[ER]{}
\fancyfoot[C]{}

\fancyhfoffset[LE]{27pt}
\fancyhfoffset[RO]{27pt}

%% no line
\renewcommand{\headrulewidth}{0pt}

%% How to display chapter titles in the heading 
\renewcommand{\chaptermark}[1] {
  \markboth{
      \MakeUppercase{\@chapapp\ \thechapter---#1}
  }{}
}
%%% Chapter/section styling %%%

%\renewcommand{\chapter} {
%    \cleardoublepage     			% Starts new page.
%    \thispagestyle{empty}          	% Page style of chapter page is 'plain'
%    \global\@topnum\z@              	% Prevents figures from going at top of page.
%    \@afterindentfalse              	% Inserts indent in first paragraph.  Change
%    \secdef\@chapter\@schapter      	% to \@afterindentfalse to remove indent.
%}

%\newlength{\chapnint}
%
%\titleformat{\chapter}[hang]
%{\scshape\fontsize{16.18pt}{27pt}\selectfont}
%{\hspace{-27pt}\makebox[27pt][l]{\@chapapp\ \thechapter\hspace{6pt}\textperiodcentered}}
%{0pt}
%{\bfseries}

\titlespacing*{\chapter}{0pt}{0pt}{27pt}

\makeatletter

\renewcommand{\chapter} {
    \clearpage     			% Starts new page.
    \thispagestyle{empty}          	% Page style of chapter page is 'plain'
    \global\@topnum\z@              	% Prevents figures from going at top of page.
    \@afterindentfalse              	% Inserts indent in first paragraph.  Change
    \secdef\@chapter\@schapter      	% to \@afterindentfalse to remove indent.
}

\newlength{\chapnint}

\renewcommand{\@makechapterhead}[1]
{
  \vspace*{12 pt}
  {
    \setlength{\parindent}{0pt} 
    \setlength{\chapnint}{-27pt - 1ex - 1pt} 	% set the negative indent to align the title 
    \hspace{\chapnint}				% with the section numbers
    \raggedright\normalfont\huge \bfseries\scshape
    {\rm\scshape\@chapapp\ \thechapter\thinspace\textperiodcentered\ }#1
    \par\nobreak\vspace{24pt}
  }
}

\titlespacing*{\chapter}{0pt}{0pt}{27pt}


%\renewcommand{\@makeschapterhead}[1]
%{
%  \vspace*{12 pt}
%  {
%    \setlength{\parindent}{0pt} 
%    \setlength{\chapnint}{-27pt - 1ex - 1pt} 	% set the negative indent to align the title 
%    \hspace{\chapnint}				% with the section numbers
%    \raggedright\normalfont\huge\scshape
%    {\bfseries#1}
%    \par\nobreak\vspace{24 pt}
%  }
%}

%PhD
\titleformat{\section}[hang]
{\fontsize{11.5pt}{13.5pt}\selectfont}
{\hspace{-27pt}\makebox[27pt][l]{\thesection}}
{0pt}
{\bfseries}
\titlespacing*{\section}{0pt}{8.343pt}{5.157pt}

\titleformat{\subsection}[hang]
{\normalsize}
{\hspace{-27pt}\makebox[27pt][l]{\thesubsection}}
{0pt}
{\bfseries}
\titlespacing*{\subsection}{0pt}{8.343pt}{5.157pt}

\titleformat{\subsubsection}[hang]
{\normalsize}
{\hspace{-27pt}\makebox[27pt][l]{\thesubsubsection}}
{0pt}
{\bfseries}
\titlespacing*{\subsubsection}{0pt}{8.343pt}{5.157pt}

% MSC
%\renewcommand{\section}{\@startsection{section}{1}{0pt}
%      {6pt}
%      {1pt}{\normalfont\large\bf}
%}
%\titlespacing*{\section}{0pt}{8.343pt}{5.157pt}
%
%
%\renewcommand{\subsection}{\@startsection{subsection}{2}{0pt}
%      {3pt}
%      {0.1pt}{\normalfont\normalsize\bf}
%}
%\titlespacing*{\subsection}{0pt}{8.343pt}{5.157pt}
%
%\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0pt}
%      {0pt}
%      {0.1pt}{\normalfont\normalsize\bf}
%}
%\titlespacing*{\subsubsection}{0pt}{8.343pt}{5.157pt}

%\def\@seccntformat#1{\rlap{\rm\hskip-27pt\csname the#1\endcsname}}

%%% Proof styling %%%

\definecolor{proofcolor}{RGB}{0,0,0}

% Dark orange and Dark Red rgb
\definecolor{theorembordercolor}{RGB}{151, 63, 5}
\definecolor{theorembackgroundcolor}{RGB}{248, 241, 234}

%\newtheoremstyle{theorem}
%{0pt}{0pt}{\normalfont}{0pt}
%{}{\;}{0.25em}
%{{\sffamily\bfseries\color{theorembordercolor}\thmname{#1}~\thmnumber{\textup{#2}}.}
%\thmnote{\normalfont\color{black}~(#3)}}

%%% Helpful environments %%%

%\newenvironment{narrow}[2]{%
%	\begin{list}{}{%
%		\setlength{\topsep}{0pt}%
%		\setlength{\leftmargin}{#1}%
%		\setlength{\rightmargin}{#2}%
%		\setlength{\listparindent}{\parindent}%
%		\setlength{\itemindent}{\parindent}%
%		\setlength{\parsep}{\parskip}}%
%		\item[]}
%	{\end{list}}

%\newlength{\asidewidth}
%\setlength{\asidewidth}{\textwidth - 27pt}

%\newenvironment{aside}
%{
%    \begin{minipage}[t]{\textwidth - 162pt}
%    \begin{it} 
%}
%{
%    \end{it}
%    \end{minipage}
%    \vspace{0pt}
%}
\newenvironment{aside}{
	\hspace{7.5pt}
	\setlength{\leftskip}{13.5pt}\par\itshape\noindent
}{
	
	\hspace{6pt}\setlength{\leftskip}{0em}\par\NoIndentAfterThis
}

%\newcommand{\footnoteremember}[2]{
%  \footnote{#2}
%  \newcounter{#1}
%  \setcounter{#1}{\value{footnote}}
%}
%\newcommand{\footnoterecall}[1]{
%  \footnotemark[\value{#1}]
%}

% non-indented, spaced paragraphs
\setlength{\parindent}{13.5pt}
\setlength{\parskip}{0pt}


