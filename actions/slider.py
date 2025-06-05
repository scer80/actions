"""
marimo run actions/slider.py --host 0.0.0.0 --port 8500
"""

import marimo

app = marimo.App()


@app.cell
def slider_cell():
    import marimo as mo

    frequency = mo.ui.slider(start=0.1, stop=10, label="Frequency", value=2.0)
    return frequency


@app.cell
def display_sine_wave(frequency):
    import marimo as mo
    import matplotlib.pyplot as plt
    import numpy as np

    amplitude = 1.0  # Adjust as needed
    f = frequency.value
    f"Square of {frequency.value} is {frequency.value ** 2}"
    t = np.linspace(-10, 10, 200)
    f = amplitude * np.sin(f * t)
    plt.plot(t, f)
    axis = plt.gca()
    axis.grid(True)
    mo.md(
        f"""
        ## Sine Wave Plot

        {mo.as_html(axis)}
        """
    )
