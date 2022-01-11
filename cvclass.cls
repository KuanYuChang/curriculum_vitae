%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2021, 2022 Kuan-Yu Chang
%
% This file may be distributed and/or modified
%
% 1. under the LaTeX Project Public License and/or
% 2. under the GNU Public License.
% 
% The latest version of this file can be found at:
%.   https://github.com/yu020009/curriculum_vitae
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cvclass}[2022/1/11 v1.7 Curriculum Vitae class]
\LoadClass[10pt,a4paper]{article}
\pagestyle{empty}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Require Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[T1]{fontenc}
\RequirePackage{microtype}
\RequirePackage{geometry}
\RequirePackage{soul}
\RequirePackage{titlesec}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage[backend=biber,style=ieee]{biblatex}
\RequirePackage{hyperref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Typesetting Document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Margins

\geometry{left=0.75in,top=0.6in,right=0.75in,bottom=0.6in}

%% Paragraphs

\setlength{\parindent}{0pt}

%% Section title

\titleformat{\section}
    {\fontfamily{ptm}\selectfont\Large\scshape\bfseries}
    {}{0em}{}[{\vspace{-2pt}\titlerule[.8pt]}]

%% Height of the underlines

\setuldepth{Abc}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Personal Information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Variables (set to empty by default)

\let \@name \relax \def\@name{}
\let \@jobtitle \relax \def\@jobtitle{}
\let \@address \relax \def\@address{}
\let \@phone \relax \def\@phone{}
\let \@email \relax \def\@email{}

\def \name#1{\def\@name{#1}}
\def \jobtitle#1{\def\@jobtitle{#1}}
\def \address#1{\def\@address{#1}}
\def \phone#1{\def\@phone{#1}}
\def \email#1{\def\@email{#1}}

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

\newcommand{\experience}[6]{
    \begin{tabularx}{\linewidth}{Xr}
        \textbf{#1} & \multirow{4}{*}{\includegraphics[#5]{#6}} \\
        \textit{#2} \\ \textit{#3} \\ #4
    \end{tabularx}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List of Items
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\sepitem}[2]{\item \textbf{#1} \hfill #2}
\newenvironment{plainitemize}[1]{
    \begin{itemize}[leftmargin=*,label={#1},noitemsep]}{
    \end{itemize}}
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Education
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\education}[5]{
    \begin{tabularx}{\linewidth}{Xr}
        \textbf{#1} &
            \multirow{3}{*}{\includegraphics[#3]{#4}} \\ \\
        \textit{\ul{#2}} \\ \\
        \begin{minipage}[t]{\linewidth}
        \begin{plainitemize}{-}
            #5
        \end{plainitemize}
        \end{minipage}
    \end{tabularx}}
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Publications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Bibliography source

\addbibresource{publications.bib}

%% List all items

\newcommand{\makepublications}{
    \nocite{*}
    \printbibliography[title=Publications]}

%% Author annotation

\renewcommand*{\mkbibnamegiven}[1]{
    \ifitemannotation{highlight}{\textit{\textbf{#1}}}{#1}}
\renewcommand*{\mkbibnamefamily}[1]{
    \ifitemannotation{highlight}{\textit{\textbf{#1}}}{#1}}

%% Customized fields (map to usera, userb, and userc)

\DeclareSourcemap{
    \maps[datatype=bibtex]{
      \map{\step[fieldsource=pdf] \step[fieldset=usera,origfieldval]}
      \map{\step[fieldsource=poster] \step[fieldset=userb,origfieldval]}
      \map{\step[fieldsource=video] \step[fieldset=userc,origfieldval]}}}

%% Formatting customized fields

\DeclareFieldFormat{usera}{\href{#1}{[pdf]}}
\DeclareFieldFormat{userb}{\href{#1}{[poster]}}
\DeclareFieldFormat{userc}{\href{#1}{[video]}}

%% Place customized fields at the end of an item

\AtEveryBibitem{%
    \csappto{blx@bbx@\thefield{entrytype}}{%
        \iffieldundef{usera}{}{\space\printfield{usera}}%
        \iffieldundef{userb}{}{\space\printfield{userb}}%
        \iffieldundef{userc}{}{\space\printfield{userc}}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{references}{
    \section{References}
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
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Last update
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndDocument{\vfill\hfill \small \em Last updated on \today.}
