# Bakery

## The story

One year and a half ago I became an iOS developer, I was happy, I knew how to do iOS apps, but static ones. I saw the animations behind Paper, or the transitions behind Mail, and I was impressed, I wanted to do that. After trying and trying, I did some great animations, I learnt FramerJS, which, in my opinion, has some beauty in it's springs, and I felt in love with it. Trying to learn more and more, I saw an article that talked about the animations in UIKit, and I started to investigate about spring, I saw that, putting a timing on it didn't make sense, and that's the reason why I want to bring the perfect animation to iOS development, the, in my opinion best platform to develop on.

## Code

To do animations the code used will be similar to this:

```
animate(firstView) {
  $0.alpha(1)
}.chain {
  $0.width(300)
}.finally {
  print("Animation done")
}
```

## Upcoming features

- [x] Spring animation.
- [x] Width, height and size animations.
- [ ] Change the name. x
- [ ] Report bug of the chain thing that it doesn't recognize the signature.
- [ ] Add Swift proposal to add arrays as a back for closures.
- [ ] Add animation options. x
- [x] Call animate two times or more, so add a queue.
- [x] Be careful when you tap two animate multiple times. (Add a flag to lock the main methods).
- [x] Multiple animate or spring blocks.
- [x] Document the code.
- [x] Document bake.
- [ ] Add an easy way to create animations, spring and bezier's. x
- [x] Cancel all animations.
- [x] Apply bounce in the Spring.
- [ ] Add a general method for reverse more than one animation.

## Done by

Ramon Gilabert. With love.
