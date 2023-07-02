%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%  Copyright (C) 2012-2013 by Michiel Helvensteijn - www.mhelvens.net          %
%                                                                              %
%  This work may be distributed and/or modified under the                      %
%  conditions of the LaTeX Project Public License, either                      %
%  version 1.3 of this license or (at your option) any later                   %
%  version. The latest version of this license is in                           %
%      http://www.latex-project.org/lppl.txt                                   %
%  and version 1.3 or later is part of all distributions of                    %
%  LaTeX version 2005/12/01 or later.                                          %
%                                                                              %
%  This work has the LPPL maintenance status `author-maintained'.              %
%                                                                              %
%  The Current Maintainer of this work is Michiel Helvensteijn.                %
%                                                                              %
%  This work consists of the file packagedoc.cls.                              %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\packagename\jobname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document Class                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClassWithOptions{ltxdoc}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Importing The Relevant Package                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{\packagename}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Importing Other Packages                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\RequirePackage[hyphens]{url}

\RequirePackage{etoolbox}
\RequirePackage[xcolor]{mdframed}
\RequirePackage{marginnote}
\RequirePackage{listings}
\RequirePackage{textcomp}
\RequirePackage[colorlinks=true]{hyperref}
\RequirePackage{noindentafter-dry}
\RequirePackage{needspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Documentation Options                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\EnableCrossrefs         
\CodelineIndex
\RecordChanges

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Info                                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\GetFileInfo{\packagename.sty}

\title{The \textsf{\packagename} package\thanks{%
  This document corresponds to \textsf{\packagename}~\fileversion,
  dated \filedate.%
}}

\author{
  Michiel Helvensteijn\\
  \href{mailto:mhelvens+latex@gmail.com}{mhelvens+latex@gmail.com}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Development Info                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newmdenv[
  leftline  = false,
  rightline = false
]{bannerframe}

\apptocmd{\maketitle}{
  \begin{bannerframe}
    \small
    \begin{center}
      Development of this package is organized at
      \href{http://latex-\packagename.googlecode.com}
                  {latex-\packagename.googlecode.com}.\\
      I am happy to receive feedback there!
    \end{center}
  \end{bannerframe}
}{}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example Environment Setup                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Extra keywords for LaTeX
%
\newcommand{\moretexcs}[1]{
  \lstdefinelanguage{latex}{
    language=[LaTeX]tex,
    alsoletter={\[,\],\$},
    moretexcs={ExplSyntaxOn,ExplSyntaxOff,lstinputlisting,detokenize,[,],#1},
    keywords={\$}
  }
}

%%% Code formatting
%
\lstdefinestyle{examplecode}{%
  language=latex,%
  basicstyle=\ttfamily\small,%
  texcsstyle=*\bfseries,%
  keywordstyle=*\bfseries,%
  upquote=true%
}

%%% Setting up example code block
%
\definecolor{examplecodelinecolor}{rgb}{0,0,0}
\definecolor{examplecodebackgroundcolor}{rgb}{.9,.9,.9}
\newmdenv[
  linecolor         = examplecodelinecolor,
  backgroundcolor   = examplecodebackgroundcolor,
  skipabove         =  0pt,
  skipbelow         =  0pt,
  innertopmargin    = -1pt,
  innerrightmargin  =  1pt,
  innerbottommargin = -1pt,
  innerleftmargin   =  1pt
]{examplecodeframe}

%%% Defining example output block
%
\definecolor{exampleoutputbackgroundcolor}{rgb}{1,1,1}
\newmdenv[
  linecolor         = examplecodelinecolor,
  backgroundcolor   = exampleoutputbackgroundcolor,
  skipabove         = 0pt,
  skipbelow         = 0pt,
  innertopmargin    = 6pt,
  innerrightmargin  = 6pt,
  innerbottommargin = 6pt,
  innerleftmargin   = 6pt,
  nobreak           = true
]{exampleoutputframe}

%%% Macros for counting lines in file, adapted from
%%% http://andreas.scherbaum.la/blog/archives/
%%%        670-Read-number-lines-in-a-file-in-LaTeX.html
%
\RequirePackage{ifthen}
\newboolean{packagedoc@restfile}
\newcommand*{\packagedoc@fileline}{}
\newread\packagedoc@file
\newcommand*{\packagedoc@readnextline}[1]{%
  \ifthenelse{\boolean{packagedoc@restfile}}{%
    \read#1 to \packagedoc@fileline%
    \ifeof#1\setboolean{packagedoc@restfile}{false}%
    \else\fi%
  }{}%
}
\newcommand*{\countlinesinfile}[2]{%
  \setboolean{packagedoc@restfile}{true}%
  \setcounter{packagedoc@linecount}{0}%
  \openin\packagedoc@file=#1%
  \whiledo{\boolean{packagedoc@restfile}}{%
    \packagedoc@readnextline{\packagedoc@file}%
    \ifthenelse{\boolean{packagedoc@restfile}}{%
      \stepcounter{packagedoc@linecount}%
    }{}%
  }%
  \closein\packagedoc@file%
  \edef#2{\thepackagedoc@linecount}%
}

\newcounter{packagedoc@linecount}
\newlength{\packagedoc@spacetoreserve}

%%% DRYer without output
%
\NewDRYer{latex-example}{%
  \vskip\abovedisplayskip%
  {%
    \ttfamily\small%
    \countlinesinfile{#1}{\countedlines}%
    \setlength{\packagedoc@spacetoreserve}{\countedlines\baselineskip}%
    \addtolength{\packagedoc@spacetoreserve}{-1pt}%
    \needspace{\packagedoc@spacetoreserve}%
  }%
  \begin{examplecodeframe}%
    \renewcommand{\ttdefault}{pcr}%
    \lstinputlisting[style=examplecode]{#1}%
  \end{examplecodeframe}%
  #2%
  \vskip\belowdisplayskip%
}

%%% DRYer WITH output but WITHOUT side-effects
%
\NewDRYer{latex-example-show}{%
  \vskip\abovedisplayskip%
  {%
    \ttfamily\small%
    \countlinesinfile{#1}{\countedlines}%
    \setlength{\packagedoc@spacetoreserve}{\countedlines\baselineskip}%
    \addtolength{\packagedoc@spacetoreserve}{\baselineskip}%
    \needspace{\packagedoc@spacetoreserve}%
  }%
  \begin{examplecodeframe}%
    \renewcommand{\ttdefault}{pcr}%
    \lstinputlisting[style=examplecode]{#1}%
  \end{examplecodeframe}\vspace{-1pt}%
  \begin{exampleoutputframe}%
    #2%
  \end{exampleoutputframe}%
  \vskip\belowdisplayskip%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementation Code Box Setup                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Saving old implementation code block font
%
\AtBeginDocument{\let\old@macro@font\macro@font}

%%% Setup for 'interesting' implementation code blocks
%
\definecolor{interestingcodebackgroundcolor}{rgb}{.9,.9,.9}
\definecolor{interestingcodelinecolor}{rgb}{0,0,0}
\mdfdefinestyle{interestingcode}{
  linecolor       = interestingcodelinecolor,
  backgroundcolor = interestingcodebackgroundcolor
}
\newcommand*{\interesting}{%
  \def\codestyle{interestingcode}%
  \def\codeskipabove{2pt}%
  \let\macro@font\old@macro@font%
}

%%% Setup for 'UNinteresting' implementation code blocks
%
\definecolor{uninterestingcodebackgroundcolor}{rgb}{.97,.97,.97}
\definecolor{uninterestingcodelinecolor}{rgb}{.5,.5,.5}
\definecolor{uninterestingcodecolor}{rgb}{.4,.4,.4}
\mdfdefinestyle{uninterestingcode}{
  linecolor       = uninterestingcodelinecolor,
  backgroundcolor = uninterestingcodebackgroundcolor,
}
\newcommand*{\uninteresting}{%
  \def\codestyle{uninterestingcode}%
  \def\codeskipabove{-2pt}%
  \def\macro@font{\color{uninterestingcodecolor}\old@macro@font}%
}

%%% Actually surround 'macrocode' with the frame
%
\surroundwithmdframed[
  style             = \codestyle,
  skipabove         = \abovedisplayskip,
  skipbelow         = \belowdisplayskip,
  splittopskip      = 4pt,
  splitbottomskip   = 1pt,
  innertopmargin    = -2pt,
  innerrightmargin  = 1pt,
  innerbottommargin = 5pt,
  innerleftmargin   = 4pt
]{macrocode}

%%% Start out with 'interesting' code status and
%%% always go back to it after one code block
%
\interesting
\AfterEndEnvironment{macrocode}{\interesting}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Argument Specifiers and such                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\movarg}[1]{[ \texttt{#1} ]}
\newcommand*{\momarg}[1]{[ \meta{#1} ]}

\newcommand{\describemacro}[2]{%
  \needspace{3\baselineskip}%
  \noindent\\\DescribeMacro{#1} #2\\%
}

\newcommand{\describemetamacro}[2]{%
  \needspace{3\baselineskip}%
  \noindent\\\marginnote{\meta{#1}} #2\\%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Automatic Implementation Docs                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndDocument{
  \section{Implementation}
  
  \StopEventually {\PrintChanges}
  
  We now show and explain the entire implementation from \texttt{\packagename.sty}.
  
  \DocInput{\packagename.sty}
  
  \Finale
  
  \PrintIndex
}
