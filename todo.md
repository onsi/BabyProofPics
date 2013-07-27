- Transition
    - Add transition delegate
    - Simulator should snap bubble to the middle (*currently the snap behavior is misbehaving... perhaps it will be fixed in an update?, alternatively use CAAnimation's valueFunction to interpolat between the simulator and the goal).
    - Once snapped the bubble should be removed from the simulator
    X Bubble should be able to expand itself to fill the screen (just the bounds + corner radius, not the center)
        X Getting the video feed sublayer to scale correctly could involve *subclassing* the bubble view (?)
    - After the bubble animates we insert the full screen view controller and insert the video feed
- Transitioning back should work too:
    - Immediately remove the full scren view and transfer the video feed to the bubble
    - Bubble should be able to animate itself back to its previous anchor point and size.
    - On animation completion we throw the bubble back into the simulator.