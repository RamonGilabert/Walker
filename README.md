![Walker](https://github.com/RamonGilabert/Walker/blob/master/Resources/header-image.png)

This is still a work in progress.

## The story

Seeing the animations behind Paper, or the transitions behind Mail, being in a world of flat design and transitions, user interaction, app behavior and responsiveness are key, we need good and fast animations to delight our users in every tap, every scroll, every moment that they spend in our app.

After lots of apps, designs and animations, after trying some of the most famous web frameworks and after I learnt FramerJS, which has one of the most beautiful springs I've seen. I'm building a collection of my knowledge, as I said when I was learning iOS development I would do, let me present Walker to you, an animation engine and library.

Walker has a bohemian companion that walks tight with him, this is [], a set of animations that will make your life easier when developing iOS apps.

## Code

Walker has different types of use cases and behaviors, you can either have a chain of animations with different blocks and callbacks, or reuse animations and apply them in different cases.

```swift
animate(view) {
  $0.alpha = 1
}.then {
  print("First animation done")
}.chain {
  $0.width = 300
}.finally {
  print("Animations done")
}
```

Inside every animation there are different curves, the basic ones, which are Linear, Ease, EaseIn, EaseOut and EaseInOut, a custom Cubic Bezier and a Spring animation.

#### Cubic Bezier

Considering Linear, Ease, EaseIn, EaseOut and EaseInOut cubic animations, the following animation will just have the Bezier one, even though everything is called the same way.

```swift
animate(view, curve: .Bezier(1, 0.4, 1, 0.4)) {
  $0.x = 40
}
```

// TODO: Put a gif going from side to side.

#### Springs

Springs are the most beautiful animations in the spectrum, taking inspiration of the curve used in FramerJS, you'll have a look alike feel that you are going to be able to configure like the following set.

```swift
spring(view, spring: 200, friction: 10, mass: 10) {
  $0.x = 40
}
```

// TODO: Put a gif here.

#### Chains

As stated in the first example, you can chain animations, but not only animations with the same curve, every block has an independent status, so you'll be able to chain springs and bezier animations, being notified when everything finishes if you want.

```swift
spring(view, spring: 200, friction: 10, mass: 10) {
  $0.x = 40
}.chain {
  $0.x = 100
}
```

// TODO: Put a gif here.

#### Create your own

It wouldn't be a good animation engine if you couldn't reuse animations, there's a component inside the engine called Still, this one will talk to the background motor and will provide you with a `CAKeyframeAnimation`, just by calling this:

```swift
let animation = Still.bezier(.PositionX)
```

Still can have, as the engine above, Cubic Bezier and Spring animations inside, each one configured differently. Note also that this will provide a layer animation.

Finally, this animation won't be tight to a final value or to any view, so you can reuse it across by distilling it:

```swift
distill((animation: animation, final: 50), view: view)
```

Distill works with as many animations at a time as you want.

// TODO: Put a gif here.

#### More questions?

Have more questions and want to see more implementation in detail? We have a [demo](https://github.com/RamonGilabert/Walker/tree/master/Demo/Walker) for you. If you still have something unclear, don't hesitate to [contact me](mailto:ramon.gilabert.llop@gmail.com) or [open an issue](https://github.com/RamonGilabert/Walker/issues).

## Upcoming features

Check out the [ROADMAP](https://github.com/RamonGilabert/Walker/blob/master/ROADMAP.md) to see the upcoming features that we are thinking to implement and don't hesitate to [open an issue](https://github.com/RamonGilabert/Walker/issues) or make a PR with a proposal in the roadmap.

## Done by

Ramon Gilabert with ♡.
