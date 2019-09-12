import difflib

s = "Hello World"

s1 = "Hell World"
s2 = "Hello Cruel World"
s3 = "Goodbye Hell"
s4 = "Hello Cute Cat"
s5 = "Rainy Day Comes"

sq1 = difflib.SequenceMatcher(None, s, s1, False)
sq2 = difflib.SequenceMatcher(None, s, s2, False)
sq3 = difflib.SequenceMatcher(None, s, s3, False)
sq4 = difflib.SequenceMatcher(None, s, s4, False)
sq5 = difflib.SequenceMatcher(None, s, s5, False)

print(sq1.ratio())
print(sq2.ratio())
print(sq3.ratio())
print(sq4.ratio())
print(sq5.ratio())