# Mist
Mist is a 2D game engine inspired by Unreal.

It is written primarily in Lua, with some functionality, like OS interaction and the basics of graphics subsystem, is implemented in C++11.

The facilities of the engine may also be used for other purposes. For example, 'img' library uses them for high-precision image processing.

The engine is still very early in development. The codebase is rather unstable, so there's also a large amount of code in the project that is either obsolete, or not adapted to the changed interfaces.

## Building
The main method is to use gcc Makefiles. When in the mist/ directory,
```
make -C client
```
or, depending on your needs,
```
make -C client-console
```
should produce the required binaries.
The rest of the resources, including Lua scripts, are processed at runtime, so just running the client should do it.
