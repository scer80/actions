"""Test marimo notebook functionality."""

# import marimo as mo
# import matplotlib.pyplot as plt

# plt.plot([1, 2])
# axis = plt.gca()

# mo.md(
#     f"""
#     Here is a plot:

#     {mo.as_html(axis)}
#     """
# )

# import marimo as mo
# app = mo.App()

# # frequency = mo.ui.slider(start=0.1, stop=10, label="Frequency", value=2.0)

# @app.cell
# def __():
#     import marimo as mo
#     import matplotlib.pyplot as plt
#     import numpy as np

#     amplitude = 1.0   # Adjust as needed
#     f = 1.0

#     t = np.linspace(-10, 10, 200)
#     f = amplitude * np.sin(f * t)
#     plt.plot(t, f)
#     axis = plt.gca()
#     axis.grid(True)

#     mo.md(
#         f"""
#         ## Sine Wave Plot

#         {mo.as_html(axis)}
#         """
#     )
#     return


# if __name__ == "__main__":
#     app.run()
