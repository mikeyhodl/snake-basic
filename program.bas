1050 PRINT "UP: W"
1060 PRINT "DOWN: S"
1070 PRINT "LEFT: A"
1080 PRINT "RIGHT: D"
2000 REM The array G holds one entry for each pixel
2010 REM (X, Y) maps to G[X + Y*50]
2020 REM A non-zero value in G means either the snake occupies the pixel or there is a dot on the pixel
2030 REM A dot is encoded by the value 5
2040 REM If the snake occupies the pixel, the value in G indicates the directionof the snakes motion
2050 REM 1=up, 2=down, 3=left, 4=right
2060 REM The Subroutines 9100, 9200, 9300, 9400 can be selected by adding 100 * D + 9000, where D is one of the directions 1, 2, 3, or 4
2070 ARRAY G
2080 REM === Initialize ===
2090 LET P = 12
2100 LET Q = 12
2110 LET G[P + Q *50] = 1
2120 PLOT P, Q, "green"
2130 LET R = 12
2140 LET S = 11
2150 LET G[R + S *50] = 1
2160 PLOT R, S, "green"
2170 LET G[20 + 20*50] = 5
2180 PLOT 20,20, "orange"
2300 REM === Keyboard input ===
2310 LET C = UPPERCASE(GETCHAR())
2320 IF C = "W" THEN LET G[P + Q *50] = 2
2330 IF C = "S" THEN LET G[P + Q *50] = 1
2340 IF C = "A" THEN LET G[P + Q *50] = 3
2350 IF C = "D" THEN LET G[P + Q *50] = 4
2500 REM === Move the snake ===
2510 LET D = G[P + Q *50]
2520 GOSUB 9000 + 100*G[P + Q *50]
2530 LET P = P + U
2540 LET Q = Q + V
2550 IF P > 49 OR P < 0 OR Q > 49 OR Q < 0 THEN GOTO 7000
2560 IF G[P + Q *50] THEN GOTO 3000
2570 LET G[P + Q *50] = D
2575 pause 1
2580 PLOT P, Q, "green"
2590 LET D = G[R + S *50]
2600 GOSUB 9000 + 100*G[R + S *50]
2610 LET G[R + S *50] = 0
2620 PLOT R, S, "white"
2630 LET R = R + U
2640 LET S = S + V
2650 PAUSE 500
2660 GOTO 2300
3000 REM Collision detection
3010 IF G[P + Q *50] <= 4 THEN GOTO 7000 
3020 LET F = F + 1
3030 CLT
3040 PRINT "=== Snake  ==="
3050 PRINT "Score: " + F
3060 LET G[P + Q *50] = D
3070 PLOT P, Q, "green"
3080 REM Add a new dot
3090 LET A = FLOOR(RAND(49))
3100 LET B = FLOOR(RAND(49))
3110 IF G[A + B *50] THEN GOTO 3060
3120 PLOT A, B, "orange"
3130 LET G[A + B *50] = 5
3140 GOTO 2320
7000 REM === Game Over ===
7010 CLT
7015 PRINT  "=== Snake ==="
7020 PRINT  "      Game Over"
7030 PRINT "Total score: " + F
7040 IF F < 5 THEN PRINT "- Ouch!"
7050 IF F >= 5 AND F < 15 THEN PRINT "- Nice Try!"
7060 IF F >= 15 AND F < 50 THEN PRINT "- Way to go!"
7070 IF F >= 50 AND F < 250 THEN PRINT "- Great score!"
7080 IF F >= 250 THEN PRINT "-- Amazing score!"
7090 PRINT  "====================="
7100 END
9000 REM Subroutines mapping the direction number in D (1, 2, 3, or 4) to a vector (U, V)
9100 LET U = 0
9110 LET V = 1
9120 RETURN
9200 LET U = 0
9210 LET V = -1
9220 RETURN
9300 LET U = -1
9310 LET V = 0
9320 RETURN
9400 LET U = 1
9410 LET V = 0
9420 RETURN
