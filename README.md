# vfox-shader-slang

A [vfox](https://github.com/version-fox/vfox) plugin for [shader-slang](https://github.com/shader-slang/slang).

> [!CAUTION]
> Supported versions: 2024.1.27 or later

## Installation

```shell
mise plugin install shader-slang https://github.com/horaguy/vfox-shader-slang

# Example: install the latest version globally
mise use -g shader-slang
slangc -v
```

## Usage

See [User's Guide](https://shader-slang.org/slang/user-guide/)

```shell
# Compile *.slang to *.metal
slangc input.slang -target metal -o output.metal

# Compile *.slang to *.hlsl (computeMain should be defined in input.slang)
slangc input.slang -target hlsl -entry computeMain -o output.hlsl

# Compile *.slang to *.glsl (computeMain should be defined in input.slang)
slangc input.slang -target glsl -entry computeMain -o output.glsl
```
