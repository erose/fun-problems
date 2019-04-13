t = var('t', domain='real')

for hour in range(12):
    solution = ((11/60) * t == hour).solve(t)[0].rhs()
    print "When it's the hour of", hour, "o'clock", "t =", float(solution)
