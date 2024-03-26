%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------
\ProvidesClass{resume}[2020/02/25 Basic CV Class]

%-------------------------------------------------------------------------------
%                Layout Configuration
%-------------------------------------------------------------------------------

% Pass options to article class
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Reduce space between sections
\RequirePackage{parskip}
\setlength{\parskip}{0pt}
% Deal with hyperlinks
\RequirePackage[
  colorlinks=false,
  hyperfootnotes=false
]{hyperref}
\hypersetup{
  pdftitle={\@author Resume},
  pdfauthor={\@author},
  pdfsubject={},
  pdfkeywords={},
}

% Configure page margins with geometry
\RequirePackage{geometry}
\geometry{left=2.0cm, top=1.3cm, right=2.0cm, bottom=0cm}

% Remove Page Numbers
\pagenumbering{gobble}

% ## Font
\usepackage[sfdefault]{inter}

% ### Header Font Options
\newcommand*{\headernamestyle}[1]{{\fontsize{18pt}{1em}\interheavy #1}}
\newcommand*{\headerpositionstyle}[1]{{\fontsize{12pt}{1em}\bfseries #1}}
\newcommand*{\headeraddressstyle}[1]{{\fontsize{10pt}{1em}\upshape #1}}
\newcommand*{\headerquotestyle}[1]{{\fontsize{10pt}{1em}\upshape #1}}

% ### Entry Font Options
\newcommand*{\entrytitlestyle}[1]{{\fontsize{14pt}{1em}\bfseries\MakeUppercase{#1}}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{12pt}{1em}\bfseries #1}}
\newcommand*{\entrydatestyle}[1]{{\fontsize{10pt}{1em}\interlight #1}}
\newcommand*{\entrylocationstyle}[1]{{\fontsize{10pt}{1em}\interlight #1}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{11pt}{1em}\upshape #1}}

%-------------------------------------------------------------------------------
%                Define Global Functions
%-------------------------------------------------------------------------------
% Use to execute conditional statements by checking empty string
\RequirePackage{xifthen}
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}

%-------------------------------------------------------------------------------
%                Specific Structural Formatting
%-------------------------------------------------------------------------------

% ## Header Formatting
% ### Personal Information Variables
\newcommand*{\address}[1]{\def\@address{#1}}
\newcommand*{\position}[1]{\def\@position{#1}}
\renewcommand*{\quote}[1]{\def\@quote{#1}}
% ### Header Function
\newcommand*{\makecvheader}{
  \begin{center}
    \headernamestyle{
      \@author
    }
    \\
    \vspace{0.6mm}%
    \ifthenelse{\isundefined{\@position}}{}{\headerpositionstyle{\@position\\}}
    \vspace{0.4mm}%
    \ifthenelse{\isundefined{\@address}}{}{\headeraddressstyle{\@address\\}}
    \vspace{-0.5mm}%
    \ifthenelse{\isundefined{\@quote}}
    {\vspace{1em}}
    {
      \vspace{1.2mm}
      \rule{\textwidth}{0.4pt}
      \vspace{1.0mm}
      \headerquotestyle{\@quote\\}
      \vspace{-4mm}
      \rule{\textwidth}{0.4pt}
      \vspace{-1.6mm}}
  \end{center}
  \vspace{0.25ex}
}

%-------------------------------------------------------------------------------
% ## Section Formatting
% ### Section Font Formatting
\usepackage{sectsty}
\sectionfont{\fontsize{10}{1em}\selectfont \sectionrule{0pt}{0pt}{-0.5ex}{0.6pt}}
% Define a section for CV
\newcommand{\cvsection}[1]{
  \vspace{-4ex}
  \section*{\uppercase{#1}}
  \vspace{-1ex}
}

%-------------------------------------------------------------------------------
% ## Entry Formatting
% ### Entry Environment
\newenvironment{cventries}{}

% ### Entry Functions
\newcommand*{\cvmentry}[3]{
  \ifempty{#1#2}
  {#3}
  {\entrytitlestyle{#1} \hfill \entrylocationstyle{#2} \newline #3}\vspace{1.3ex}
}
\newcommand*{\cvposition}[3]{
  \entrypositionstyle{#1} \hfill \entrydatestyle{#2} \par
  \ifempty{#3}{}{\descriptionstyle{#3}}
}
\newcommand*{\cventry}[5]{
  \cvmentry{#2}{#3}{
    \cvposition{#1}{#4}{#5}
  }
}

%-------------------------------------------------------------------------------
% ## List formatting
% ### Packages Required for Lists
\RequirePackage{enumitem}
\RequirePackage{ragged2e}
% ### List Environment
\newenvironment{cvitems}{
  \vspace{0.6ex}
  \begin{justify}
    \begin{itemize}[leftmargin=4ex, nosep, noitemsep]
      }{
    \end{itemize}
  \end{justify}
}

%-------------------------------------------------------------------------------
% ## Footer Formatting
% ### Footer Font Options
\newcommand*{\footerstyle}[1]{{\fontsize{9pt}{1em}\upshape #1}}
% ### Footnote command without mark, indent, or rule
\def\lufootnote{
\def\footnoterule{}
\def\@makefntext##1{\centering##1}
\def\@thefnmark{}
\@footnotetext
}
% ### Footer Function
\newcommand*{\makecvfooter}[1]{
  \lufootnote{
    % make hyperlink if argument is specified
    \footerstyle{
      \ifempty{#1}
      {Last updated: \today}
      {\href{#1}{Last updated: \today}}
    }
  }
}
