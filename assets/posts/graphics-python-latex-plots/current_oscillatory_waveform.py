# Imports
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

# Initial settings
script_dir = Path(__file__).parent

# Rendering settings (LaTeX + global style)
plt.rcParams.update({
    "text.usetex": True,
    "text.latex.preamble": r"\usepackage{amsmath}",
    "font.family": "serif",
    "axes.labelsize": 12,
    "font.size": 12,
    "legend.fontsize": 12,
    "xtick.labelsize": 12,
    "ytick.labelsize": 12,
    "lines.linewidth": 1.15
})

# Signal definition (damped cosine current)
Im  = 1
f   = 50
w   = 2 * np.pi * f
tau = 0.05

t = np.arange(0, 1 + 1e-4, 1e-4)

i = Im * np.cos(w * t) * np.exp(-t / tau)
envelope = Im * np.exp(-t / tau)

blueColor = (0.0000, 0.4470, 0.7410)
redColor  = (0.8500, 0.3250, 0.0980)

# Figure and Plot
plt.close('all')
fig = plt.figure(figsize=(500/72, 200/72))

hp1, = plt.plot(t, i, color=blueColor)
hp2, = plt.plot(t, envelope, '--', color=redColor)
plt.plot(t, -envelope, '--', color=redColor)

# Axes configuration
plt.grid(True)
plt.xlim(0, 200e-3)
plt.ylim(1.19 * np.array([-1, 1]))

# Ticks
xtick_values = np.arange(0, 200e-3 + 1e-9, 20e-3)
plt.xticks(xtick_values, [rf'${int(x*1e3)}$' for x in xtick_values])
plt.yticks([-1, 0, 1], [r'$-I_\mathrm{m}$', r'$0$', r'$I_\mathrm{m}$'])

# Labels
plt.xlabel(r'$t\:[\mathrm{ms}]$')
plt.ylabel(r'$i(t)$')

# Legend
plt.legend(
    [hp1, hp2],
    [r'$i(t)$', r'$\pm\,I_\mathrm{m}\,\mathrm{e}^{-t/\tau}$'],
    loc='upper right'
)

# Layout
plt.tight_layout()

# Export (vector PDF + raster PNG for web)
plt.savefig(
    script_dir / 'current_oscillatory_waveform.pdf',
    bbox_inches='tight',
    pad_inches=0
)

plt.savefig(
    script_dir / 'current_oscillatory_waveform.png',
    dpi=150,
    bbox_inches='tight',
    pad_inches=0
)

#plt.show()
