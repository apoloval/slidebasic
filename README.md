## SlideBasic

A CLI utility to create slides for presentations that can be shown in a MSX computer system using Basic. It basically transform a YAML file that describes the slides into a Basic program that could be executed in a MSX computer to have the slide pass. 

## Usage

Simple. 

```
slidebasic examples/artemisa.yml output/artemisa.asc
```

That's it. It will read the presentation in `examples/artemisa.yml` and will transform it into a suitable MSX Basic program in `output/artemisa.asc`. 

## Presentation format

See [examples/artemisa.yml](examples/artemisa.yml) for reference. 
