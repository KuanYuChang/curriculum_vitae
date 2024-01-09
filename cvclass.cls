%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2021-2024 Kuan-Yu Chang
%
% This file may be distributed and/or modified
%
% 1. under the LaTeX Project Public License and/or
% 2. under the GNU Public License.
% 
% The latest version of this file can be found at:
%     https://github.com/yu020009/curriculum_vitae
%
% Overleaf Settings
%    Compiler: pdfLaTeX
%    Tex Live version: 2019 (Legacy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cvclass}[2023/08/04 v1.12 Curriculum Vitae class]
\LoadClass[10pt,a4paper]{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[T1]{fontenc}
\RequirePackage{microtype}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{titlesec}
\RequirePackage[parfill]{parskip}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage[style=ieee,maxbibnames=99,dashed=false,defernumbers=true]{biblatex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Typesetting Document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Margins

\geometry{left=0.75in,top=0.6in,right=0.75in,bottom=0.8in}

%% Paragraphs

\setlength{\parindent}{0pt}
\setlength{\parskip}{1em}

%% Section title

\titleformat{\section}
    {\fontfamily{ptm}\selectfont\Large\scshape\bfseries}
    {}{0em}{}[{\vspace{-2pt}\titlerule[.8pt]}]

%% Page headers and footers

\pagestyle{fancyplain}
\fancyhf{} % remove everything
\renewcommand{\headrulewidth}{0pt} % remove lines as well
\renewcommand{\footrulewidth}{0.5pt}
\lfoot{\small {\em This curriculum vitae was last updated on \@lastupdate.}
    \ifx\@latestver\empty\else
        \href{\@latestver}{[Latest version]}\fi}
\rfoot{\small Page \thepage{} of \pageref*{LastPage}}

%% List of items

\setlist[itemize]{leftmargin=1.5em,noitemsep}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Personal Information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Variables (set to empty by default)

\let \@name \relax \def\@name{}
\let \@jobtitle \relax \def\@jobtitle{}
\let \@address \relax \def\@address{}
\let \@phone \relax \def\@phone{}
\let \@email \relax \def\@email{}
\let \@latestver \relax \def\@latestver{}
\let \@lastupdate \relax \def\@lastupdate{\today}

\def \name#1{\def\@name{#1}}
\def \jobtitle#1{\def\@jobtitle{#1}}
\def \address#1{\def\@address{#1}}
\def \phone#1{\def\@phone{#1}}
\def \email#1{\def\@email{#1}}
\def \latestver#1{\def\@latestver{#1}}
\def \lastupdate#1{\def\@lastupdate{#1}}

%% Formatting

\newcommand{\formatphone}[1]{\textbf{Phone:} \texttt{#1}}
\newcommand{\formatemail}[1]{\textbf{Email:} \href{mailto:#1}{\texttt{#1}}}
\newcommand{\makeinfo}{
    \ifx\@name\empty\else
        {\Huge \bfseries \scshape \@name} \bigskip \bigskip \bigskip \\
    \fi \ifx\@jobtitle\empty\else
        {\LARGE \bfseries \scshape \@jobtitle} \bigskip \bigskip \\
    \fi \ifx\@address\empty\else
        {\bfseries \@address} \bigskip \\
    \fi \ifx\@phone\empty\else
        \formatphone{\@phone} \\ 
    \fi \ifx\@email\empty\else
        \formatemail{\@email}
    \fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experiences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\experience}[7]{
    \begin{tabularx}{\linewidth}{Xr}
        \textbf{#1} & \multirow{4}{*}{\includegraphics[#5]{#6}} \\
        \textit{#2} \\ \textit{#3} \\ #4
    \end{tabularx} #7}
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Education
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\education}[5]{
    \begin{tabularx}{\linewidth}{Xr}
        \textbf{#1} &
            \multirow{3}{*}{\includegraphics[#3]{#4}} \\ \\
        \textit{\underline{#2}} \\ \\
        \begin{minipage}[t]{\linewidth} #5 \end{minipage}
    \end{tabularx}}
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Publications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Bibliography source

\addbibresource{publications.bib}

%% List all items
%% Reference:
%%   http://www.hansenlab.org/cv_bibliography_tex

\newcommand{\makepublications}{
    \nocite{*}
    \defbibnote{annote}{(* denotes the communication author)}
    \printbibliography[title=Publications,prenote=annote]}

%% Author annotation
%% Reference:
%%   https://tex.stackexchange.com/a/561064

\renewcommand*{\mkbibcompletename}[1]{%
    \ifitemannotation{hl}{\textbf{\underline{#1}}}{%
    \ifitemannotation{comm}{#1\textbf{*}}{%
    \ifitemannotation{hlcomm}{\textbf{\underline{#1}*}}{#1}}}}

%% Customized fields (map to usera, userb, etc.)

\DeclareSourcemap{
    \maps[datatype=bibtex]{
      \map{\step[fieldsource=hindex] \step[fieldset=usera,origfieldval]}
      \map{\step[fieldsource=accrate] \step[fieldset=userb,origfieldval]}
      \map{\step[fieldsource=accmeta] \step[fieldset=userc,origfieldval]}
      \map{\step[fieldsource=pdf] \step[fieldset=userd,origfieldval]}
      \map{\step[fieldsource=video] \step[fieldset=usere,origfieldval]}
      \map{\step[fieldsource=demo] \step[fieldset=userf,origfieldval]}}}

%% Formatting customized fields

\newcommand{\hindexformat}[1]{[H-index: \textbf{#1}]}
\newcommand{\accrateformat}[1]{[Acceptance Rate: \textbf{#1}]}
\newcommand{\accmetaformat}[1]{[#1]}
\newcommand{\pdfformat}[1]{\href{#1}{[pdf]}}
\newcommand{\videoformat}[1]{\href{#1}{[video]}}
\newcommand{\demoformat}[1]{\href{#1}{[demo]}}

\DeclareFieldFormat{usera}{\hindexformat{#1}}
\DeclareFieldFormat{userb}{\accrateformat{#1}}
\DeclareFieldFormat{userc}{\accmetaformat{#1}}
\DeclareFieldFormat{userd}{\pdfformat{#1}}
\DeclareFieldFormat{usere}{\videoformat{#1}}
\DeclareFieldFormat{userf}{\demoformat{#1}}

%% Place customized fields at the end of an item

\AtEveryBibitem{%
    \csappto{blx@bbx@\thefield{entrytype}}{%
        \iffieldundef{usera}{}{\space\printfield{usera}}%
        \iffieldundef{userb}{}{\space\printfield{userb}}%
        \iffieldundef{userc}{}{\space\printfield{userc}}%
        \iffieldundef{userd}{}{\space\printfield{userd}}%
        \iffieldundef{usere}{}{\space\printfield{usere}}%
        \iffieldundef{userf}{}{\space\printfield{userf}}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{references}{
    \section{References}
    \vspace{1em}
    \multicolsep0pt
    \begin{multicols}{2}}{
    \end{multicols}}

\newcommand{\reference}[4]{
    \begin{tabular}{l}
        \textbf{#1} \\
        \textit{#2} \\
        \formatphone{#3} \\
        \formatemail{#4} \\ \\
    \end{tabular}}