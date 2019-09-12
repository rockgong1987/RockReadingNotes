txt = "This is a vast world you can't traverse world in a day"
from collections import Counter
counts = Counter(txt.split())
print(counts)

# output:
#   Counter({'a': 2, 'world': 2, 'This': 1, 'is': 1, 'vast': 1, 'you': 1, "can't": 1, 'traverse': 1, 'in': 1, 'day': 1})

print(counts.most_common(2))

# output:
#   [('a', 2), ('world', 2)]

print(counts['world'])

# output:
#   2

print(counts.values())

# output
#   12

print(Counter(["hello", "world"]) + Counter(["hello", "you"]))

# output
#   Counter({'hello' : 2, 'you' : 1, 'world' : 1})

print(Counter(["hello", "world"]) & Counter(["hello", "you"]))

# output
#   Counter({'hello' : 1})