# Zero Position Actuator Design

This is a simple insert for the rotary table that will contact the normally-open switch.

The insert will contact the switch over several degrees making for some uncertainty. To counter that, in the Node-Red software (zero.c) there is a simple instruction to advance past the initial closing of the switch and then reverse to a set position. On the rotary table this matches the zero degree position.

