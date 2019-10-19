# Python 3
import random

def run_trial(p, num_steps=2000):
    position = 0
    for _ in range(num_steps):
        position += -1 if random.random() < p else 1
        if position <= 0:
            return 'Fell'
    
    return 'Lived'

if __name__ == "__main__":
    num_trials = 2000
    fall_count = 0

    for _ in range(num_trials):
        if run_trial(0.5) == 'Fell':
            fall_count += 1

    print('Fell {} out of {} times. Rate: {}'.format(fall_count, num_trials, fall_count / num_trials))
