# AdaBots Editor

ABE is a ready-to-use editor inside a docker image, preconfigured for writing AdaBots programs.

# Setup

You need to [install docker](https://docs.docker.com/get-docker/) first.
Next, we need to download [the launcher script](/bin/abe) and put it somewhere accessible:

```
curl https://raw.githubusercontent.com/TamaMcGlinn/adabots_editor/master/bin/abe > ~/.local/bin/abe
chmod +x ~/.local/bin/abe
```

Alternatively, you could clone this repo and add its bin/ directory to your PATH environment variable.

# Use

To use, open a terminal and run abe, optionally passing an existing program text file to open:

```
abe yourprogram.adb
```

Press space twice to open the top menu. Keybindings:

```
Cntrl+b   Compile file
Cntrl+s   Save
Cntrl+q   Quit
Cntrl+n   New program
```
