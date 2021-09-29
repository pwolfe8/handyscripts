#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.

; initial variables
move_dist_px = 1
check_interval_ms = 10000
MouseGetPos, x_init, y_init

; check mouse movement loop
loop
{
sleep, check_interval_ms
MouseGetPos, x_cur, y_cur
If (x_init == x_cur) and (y_init==y_cur)
    ; move relative back and forth
    MouseMove, move_dist_px, move_dist_px,, R
    move_dist_px *= -1
    MouseGetPos, x_init, y_init
}