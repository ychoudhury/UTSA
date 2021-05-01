import matplotlib.pyplot as plt
import csv
import numpy as np

a = []
with open('output.csv', 'rt') as f:
    reader = csv.reader(f,quoting=csv.QUOTE_NONNUMERIC)
    for row in reader:
        a.append(row)

x = np.reshape(a, (a.__len__(), 4))
t = x[:,0]

plt.figure(figsize=(9,6))
plt.plot(t,x[:,1],t,x[:,2],t,x[:,3],lw=2)
plt.grid(which='both', axis='both')
plt.tight_layout()
plt.xlabel('Time (s)')
plt.show()

