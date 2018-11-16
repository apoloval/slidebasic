## SlideBasic

A CLI utility to create slides for presentations that can be shown in a MSX computer system using Basic. It basically transform a YAML file that describes the slides into a Basic program that could be executed in a MSX computer to have the slide pass. 

## Install

You will need a Unix-like operating system like Linux or Mac OS X. It might work on Windows as well, if you have Ruby installed in your system and Rake works appropriately. 

SlideBasic is not in any Gems repository yet. So you **cannot install it with** `gem install slidebasic`. But you can checkout the code and execute:
```
rake install
```

That would install the gem in your local computer and will make the `slidebasic` command available. 

## Usage

Simple. 

```
slidebasic examples/artemisa.yml output/artemisa.asc
```

That's it. It will read the presentation in `examples/artemisa.yml` and will transform it into a suitable MSX Basic program in `output/artemisa.asc`. 

## Presentation format

See [examples/artemisa.yml](examples/artemisa.yml) for reference. 
