# [Home](README.md)

The vision of this unit is to train you in applied statistics and data
science for Psychology. These skills are useful not only for
quantitative research but also are highly in demand industry/job
skills. With industry and modern, agile teams in mind, we will be
using several tools that are common tools used in industry. Some of
these you may have used, some may be new. We'll introduce each.

# 1. Slack -- team communication

Slack is an instant messaging / chat platform. It is used in many
large companies and allows easier, real time communication, sharing
code, files, and images than email. A workspace just for this unit
this year has been created.

Go [here](https://join.slack.com/t/psy42102020/shared_invite/enQtOTM5MDYzNTQ0MzkxLTFiMjhmY2JjODRkYzJiMTgxNzUxZGRmNDY5YzUwNjY1ZTRlNjMwMmE4YjRkZGY1ZDMxNTZiNzZmNTBlMWI3NWI)
and then create a Slack account using your Monash email address
(i.e., @monash.edu or @student.monash.edu) and
join the PSY42102020 workspace. You should see a few channels:

- `setup` this channel is for any questions around issues installing
  and setting up software on your computer. Please DO post
  screenshots, etc. to help us help you.
- `stats` this channel is for any questions around statistical theory
  or interpretation of output, etc.
- `duringlecture` this channel will be used during live lectures for
  real time questions and answers, sharing any extra code /
  information (e.g., if to answer a question during lecture, some code
  example is needed).
- `general` Any other questions not covered by another channel.

Although Moodle forums also will be available, Slack provides easier
real time interactions that are closer to how real teams work and
operate. Please feel free to chat openly, ask and answer questions
with each other in this space. If you need specific help from one of
the teachers you can use "@name" to mention them specifically and tag
them to look at a particular message.

# 2. GitHub -- collaborative code

GitHub is an amazing platform and tool for building software, storing
and managing code with over 40 million people actively using it.
GitHub performs **version control** which just means keeping a history
of all changes to a file, and lets you store and share files. By
keeping a history, multiple people can work on files and then merge or
combine their changes so it is common to use it for software
development. Although its very powerful, in this unit, we will just
introduce it and use it in a simple way. The lecture content and other
support resources (worksheets, etc.) will be made available through
GitHub. To use GitHub for this unit, follow these steps:

1.  Create an account [here](https://github.com/), 
    or if you already have an account, just sign in.

2.  Once you are signed up, download the desktop app
	[here](https://desktop.github.com/).
	
3.  Go to the repository (a collection of files and folders in GitHub)
    for PSY4210, located
    [here](https://github.com/JWiley/MonashHonoursStatistics).
	Then click on "Clone or download" to get all the files synced to
    your own computer.
	
4.  Make sure to regularly "pull" (download) the latest version to
    your computer. We will update files regularly, for example adding
    the latest information for later lectures and updating or
    clarifying any materials as you all ask questions or find any
    errors. That is the whole beauty of GitHub: it lets files be
    edited and updated keeping a history but also letting you get the
    very latest versions.

# 3. Install and Setup `R`


`R` is primarily a language. To have a nicer way to
interact with and use `R` we will use RStudio. RStudio is known as an
*I*ntegrated *D*evelopment *E*nvironment or IDE. It is a program that
helps to keep your code, output, graphs, and files all together in one
place. *Please follow these steps on your own laptop/computer* so that
you can work on the unit and later in your studies or work 
from anywhere and do not depend on lab computers or a good internet
connection.

**As an alternative, if you are having trouble or cannot install `R`,
as a Monash member, you can access it through Monash MoVE
[here](https://move.monash.edu/).** When you login, choose "RStudio"
and you are ready to go.

*Note, with many of the instructions, especially on a Mac, a lot of
output code will be generated. You do not need to be able to read or
understand this and it is normal.*

## Windows OS

1.  **Download `R`** by going [here](https://cloud.r-project.org/) and
    clicking on "Download R for Windows" then click on "install R for the
	first time" which should let you "Download R **3.6.2** for Windows". 
	If you are having difficulty finding it, this link may help get you
	[straight there](https://cloud.r-project.org/bin/windows/base/).
	
2.  Once you have downloaded `R` double click the file to install it
    on your own computer. Follow the step by step installation guide
    that pops up.

3.  **Download RStudio** this is an interface to `R` and makes it much
    nicer to work with. To download it, just go
    [here](https://www.rstudio.com/products/rstudio/download/#download) 
	and then under the "Installers" pick your operating system
    (Windows 7+). 
	
4.  Once you have downloaded RStudio, double click to install it and
    follow the step by step installation guide.
	
5.  Once you think you've followed all the installation steps, move on
    to the next section to Try `R`.

## macOS

1.  The first step in getting `R` running on macOS is to make sure
    that you have the latest version of macOS. This is important as
    the installation process differs across versions.
	At the time of writing, the latest version is macOS Mojave
    10.14.6. You can get help with upgrading from Apple 
	[here](https://www.apple.com/au/macos/how-to-upgrade/).

2.  Install `X Code` from App Store. *After installation*, **open it** to
    accept terms otherwise it may not work. You can see a video guide
    [here](https://www.youtube.com/watch?v=DpEUllHV670).

3.  Once you have `X Code` installed, you also need to install command
	line tools. Open `Terminal` (if you cannot find it, try spotlight
	search) and type in: `xcode-select --install` then hit enter to
	run. See a video guide 
	[here](https://www.youtube.com/watch?v=AwZ_G6-pIVg).
	If you run into any access issues, you may need to enable
	root. You can do that by type in Terminal the following: 
	`dsenableroot` and hit enter/return to enable root user.
    *Note that at the terminal, if you are asked to enter a password,
    type the password you use to login to your Mac and press
    enter/return. When typing your password in the terminal, no
    characters will appear, but it is still being entered.*
	
4.  Install `XQuartz/X11`. Go 
	[here](https://www.xquartz.org/), download and run the file and
	follow any on screen instructions.

5.  Install `clang`: go to `R` page
	[here](https://cran.rstudio.com/bin/macosx/tools)
	From there, download and install `clang-7.0.0.pkg`.
	**do not install clang-8** as that is for the beta version of
	`R`.

6.  Install `gfortran`: go 
    [here](https://github.com/fxcoudert/gfortran-for-macOS/releases)
    and download `gfortran 8.2 for Mojave`. Download and install
    following any instructions.

7.  Install `homebrew` for macOS. Go [here](https://brew.sh/) 
    and follow the "Install Homebrew" steps.
    If you run into any access issues, you may need to enable
	root. You can do that by type in Terminal the following: 
	`dsenableroot` and hit enter/return to enable root user.
    *Note that at the terminal, if you are asked to enter a password,
    type the password you use to login to your Mac and press
    enter/return. When typing your password in the terminal, no
    characters will appear, but it is still being entered.*
	
8.  Install `openssl` which will allow `R` to securely download files
    and packages from the internet.  Do this by opening the terminal
    (you can search for "terminal" or look in the launchpad) and type
    this code once the terminal opens and press enter: 
	`brew install openssl`

9.  Install `libgit2` which is needed for one of our graphing
    packages. Do this by opening the terminal
    (you can search for "terminal" or look in the launchpad) and type
    this code once the terminal opens and press enter:
	`brew install libgit2`

10. **Download `R`** by going [here](https://cloud.r-project.org/) and
    clicking on "Download R for (Mac) OS X" then download the download
    the latest version. Once you have downloaded `R` make sure to
    install it to your apps.

11. **Download RStudio** this is an interface to `R` and makes it much
    nicer to work with. To download it, just go
    [here](https://www.rstudio.com/products/rstudio/download/#download) 
	and then under the "Installers" pick your operating system. 
	Once you have downloaded RStudio, make sure to install it to your
    apps. 
	
12. Make sure that `R.app` and `RStudio.app` are able to access disk
    resources needed. Follow
	[this guide](https://www.r-bloggers.com/escaping-the-macos-10-14-mojave-filesystem-sandbox-with-r-rstudio/)
	to give them the necessary permissions.

13. Once you think you've followed all the installation steps, move on
    to the next section to Try `R`.

# 4. Try `R`

To make sure that `R` and RStudio are installed and working correctly,
follow these steps:

1.  Find and open RStudio on your computer.  *On Windows OS this
    should be under all of your programs/applications (on Windows 10
    open the start menu and search for RStudio).  On macOS you can
    try spotlight search, but if it installed but does not show on
    spotlight search, try looking in the launchpad.* Once you have
    RStudio opened, there should be several "windows".
	
2.  Go to the window named "Console" and click at the prompt. The
    prompt is just this symbol: ">".
	
3.  At the console prompt, type this code and then press "enter"/"return":

```r 

3 + 1

```

If everything worked, `R` should return the answer, "[1] 4". 
_Note: the [1] just means that the answer, 4, is in position 1._
If not, double check the installation steps. If you are stuck, post on
the Moodle Discussion Forum promptly so we can help you figure things
out. 

Assuming everything is working, try to run this code at the console to
install a few packages we will be using this semester. 
`R` may generate a lot of output and strange code. Most of that is
OK. However, you should keep notes on any **Error** messages (just copy
and paste from the console) and raise these on the class discussion
boards if you are stuck. Note that you will not be using any of these
right now. Just try to run it so everything is installed and ready to
go. 

Please Post problems and errors to the discussion forum also will help
us troubleshoot so that in later weeks when we present analyses, you
have a fully functioning `R` on your system.

# 5. Learn about RStudio

To find out a bit more about RStudio, you can watch this <5 minute
[video](https://www.youtube.com/watch?v=V_NoBcxpYC8).

If you want something for future reference on RStudio,
try this 
[cheat sheet](https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf).

# 6. DataCampe: Learn about `R`

To begin learning `R` we are going to be using the online platform,
DataCamp. Follow the instructions on Moodle for getting your account
setup. Then head over to [DataCamp](https://www.datacamp.com/), sign
in with your Monash account, and go to "My Class". Note the first 1-2
weeks will be fairly instense as to follow the class, you need to get
up to a basic ability to read and follow `R` code. The DataCamp
activities are official homework and are assessed, based on the number
completed (full marks if all completed).



# 5. Install `R` Packages

This section will have you pre-install many packages we will use
during the honours unit.

```r 

## some general language features, used in other packages
install.packages("rlang", dependencies = TRUE)

## reshape data (for longitudinal datasets)
install.packages("reshape2", dependencies = TRUE) 

## general data management
install.packages("data.table", dependencies = TRUE) 

## work with longitudinal data
install.packages("zoo", dependencies = TRUE) 

## work with date/time data
install.packages("chron", dependencies = TRUE) 

## read text files into R
install.packages("readr", dependencies = TRUE) 

## read Excel files into R
install.packages("readxl", dependencies = TRUE)

## read SPSS, STATA, and SAS files into R
install.packages("haven", dependencies = TRUE) 

## mixed effects models
install.packages("lme4", dependencies = TRUE) 

## beautiful graphs in R
install.packages("ggplot2", dependencies = TRUE) 

## create panels of plots in R
install.packages("cowplot", dependencies = TRUE) 

## beautiful colours for plots in R
install.packages("viridis", dependencies = TRUE) 

## visreg app helps visualize regression models easily
install.packages("visreg", dependencies = TRUE)

## multiple imputation
install.packages("mice", dependencies = TRUE) 


## load the packages (basically open/run the apps)
library(reshape2)
library(data.table)
library(zoo)
library(chron)
library(readr)
library(readxl)
library(haven)
library(lme4)
library(ggplot2)
library(cowplot)
library(viridis)
library(visreg)
library(mice)

```

The package installation may generate a lot of output. Finally loading
the packages (the `library()` code) will not do anything, although you
may get some notes or messages. If you do not receive any errors or
messages like 
"Error in library(readr) : there is no package called 'readr'"
That is considered a successful outcome of this step.

_Note that generally any text entered at the
console is assumed to be a command to `R`. The exception is that text
following a hashtag, #, is treated as a comment, not a command. This
is a helpful way to document code, so you know what the purpose of a
particular piece of code is._

# 6. Lecture 01 Worksheet

In preparation for the first lecture, download these two files: 

- [Intro R Worksheet](IntroR_worksheet.R) and
- [Example Excel Data](actigraph_scored_31.xlsx)

to your laptop into a folder for the unit. Try opening RStudio and
then going to 
`File -> Open File -> and navigate to IntroR_worksheet.R` 
You should be able to open it and see the code
in RStudio. No need to go through it yet. We will do that in class.

# 7. Summary and Checklist

This module covers installing and setting up `R` and RStudio. You have
a functioning version of `R` on your own computer. Before the first
lecture, make sure you've done everything by going through this
checklist.

- [ ] `R` is installed
- [ ] RStudio is installed and you can open and use it to add numbers
- [ ] You have watched/read the basics about RStudio
- [ ] You are registered and can access DataCamp and/or have posted to
  the discussion board so we can make sure you have access to DataCamp
- [ ] You have completed the "Introduction to R" section on DataCamp
- [ ] You bring your laptop to every lecture and have RStudio open
  ready to follow along any activities.
- [ ] Packages have been installed and/or you have posted
  problems/errors to the discussion board
