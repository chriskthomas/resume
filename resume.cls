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

% Make it easier for resume scanners
\input{glyphtounicode}
\pdfgentounicode=1

% Configure page margins with geometry
\RequirePackage{geometry}
\geometry{left=2.0cm, top=1.5cm, right=2.0cm, bottom=1.5cm}

% Remove Page Numbers
\pagenumbering{gobble}

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
% ### Header Font Options
\newcommand*{\headernamestyle}[1]{{\fontsize{18pt}{1em}\bfseries #1}}
\newcommand*{\headerpositionstyle}[1]{{\fontsize{10pt}{1em}\scshape #1}}
\newcommand*{\headeraddressstyle}[1]{{\fontsize{8pt}{1em}\upshape #1}}
\newcommand*{\headerquotestyle}[1]{{\fontsize{10pt}{1em}\upshape #1}}
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
    \vspace{0.6mm}
    \ifthenelse{\isundefined{\@position}}{}{\headerpositionstyle{\@position\\}}
    \vspace{0.4mm}
    \ifthenelse{\isundefined{\@address}}{}{\headeraddressstyle{\@address\\}}
    \vspace{-0.5mm}
    \ifthenelse{\isundefined{\@quote}}
    {\vspace{2.0mm}}
    {
      \vspace{1.2mm}
      \rule{\textwidth}{0.4pt}
      \vspace{1.0mm}
      \headerquotestyle{\@quote\\}
      \vspace{-4mm}
      \rule{\textwidth}{0.4pt}
      \vspace{-1.6mm}}
  \end{center}
}

%-------------------------------------------------------------------------------
% ## Section Formatting
% ### Section Font Formatting
\usepackage{sectsty}
\sectionfont{\fontsize{14pt}{1em} \sectionrule{0pt}{0pt}{-0.6ex}{1pt}}
% Define a section for CV
\newcommand{\cvsection}[1]{
  \vspace{-3.5ex}
  \section*{#1}
  \vspace{-1ex}
}

%-------------------------------------------------------------------------------
% ## Entry Formatting
% ### Entry Font Options
\newcommand*{\entrytitlestyle}[1]{{\fontsize{10.5pt}{1em}\bfseries #1}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{9pt}{1em}\scshape #1}}
\newcommand*{\entrydatestyle}[1]{{\fontsize{9pt}{1em}\slshape #1}}
\newcommand*{\entrylocationstyle}[1]{{\fontsize{10pt}{1em}\slshape #1}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{10pt}{1em}\upshape #1}}
% ### Entry Environment
\newenvironment{cventries}{
  \begin{center}
    }{
  \end{center}
}
% ### Entry Functions
\newcommand*{\cvmentry}[3]{
  \ifempty{#1#2}
  {#3}
  {\entrytitlestyle{#1} \hfill \entrylocationstyle{#2} \newline #3} \vspace{1.618ex}
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
  \vspace{1ex}
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
