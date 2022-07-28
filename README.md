# AdaBots Editor

ABE is a ready-to-use editor inside a docker image, preconfigured for writing AdaBots programs.
I have bundled Adabots, Alire, and gprbuild and built all of it already inside the docker image,
which brings the setup instructions down to a single download, and build-times down from over 10 minutes to a few seconds.

![screenshots of ABE overload with text](/demo.png)

## Beginners in mind

ABE is built on NeoVim, but features an 'insert-mode-for-everything' plugin called 'Beginner mode'
which gives a more familiar environment for non-vim users. You can turn it off in the options menu.

## Setup

You need to [install docker](https://docs.docker.com/get-docker/) first.
Next, we need to download [the launcher script](/bin/abe) and put it somewhere accessible:

```
curl https://raw.githubusercontent.com/TamaMcGlinn/adabots_editor/master/bin/abe > ~/.local/bin/abe
chmod +x ~/.local/bin/abe
```

Alternatively, you could clone this repo and add its bin/ directory to your PATH environment variable.

## Use

To use, create a directory that will house your programs, open a terminal in that and run abe,
optionally passing an existing program text file to open:

```
abe
```

Press Cntrl+space to open the top menu, which gives access to all of ABE's functionality. Keybindings:

```
Cntrl+b   Compile file
Cntrl+s   Save
Cntrl+q   Quit
Cntrl+n   New program
```
