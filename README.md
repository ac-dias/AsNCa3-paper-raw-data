# AsNCa3-paper-raw-data

Raw input/output files to reproduce the computational study on the optoelectronic properties and photovoltaic potential of the antiperovskite **AsNCa₃** (manuscript under review, 2025).

---

## Repository scope

This repository adheres to the FAIR data principles—*Findable, Accessible, Interoperable,* and *Reusable*.  All critical input decks, selected output data, and minimal post‑processing scripts are provided so that readers can:

1. **Verify** every key result reported in the paper (band structures, DOS, phonons, PCE).
2. **Reuse** the data for derivative work (e.g., alloying studies, ML training sets).
3. **Learn** best practices for hybrid DFT + tight‑binding workflows.

> **Note:** The files are organized by purpose rather than by software package to facilitate cross-code comparisons.

---

## Directory overview

| Folder                                                       | Contents                                                                                                                  | Typical file types                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| `KPATH/`                                                     | High‑symmetry k‑point paths used for all band‑structure plots (set in reciprocal lattice units).                   | `kpath.dat`, `highsym.json`                           |
| `TB-data/`                                                   | Maximally localised Wannier functions (MLWFs) and tight‑binding Hamiltonians used by WanTiBEXOS for optical calculations. | `*.amn`, `*.mmn`, `wannier90.wout`, `ham_tb.dat`      |
| `bands/`                                                     | Raw band‑energy eigenvalues on                                                                                            |                                                       |
| *dense* and *high‑symmetry* k‑meshes, plus plotting scripts. | `EIGENVAL`, `band.dat`, `plot_bands.py`                                                                                   |                                                       |
| `converged_structures_vasp/`                                 | Fully relaxed crystallographic files from VASP (PBE and HSE06).                                                           | `POSCAR`, `CONTCAR`, `OUTCAR`                         |
| `converged_structures_xtb/`                                  | Geometry‑optimised structures from xTB (GFN1‑xTB) used for phonon calculations.                                           | `*.xyz`, `xtbopt.log`                                 |
| `dos/`                                                       | Total and projected DOS data together with the script that generated Fig. 3 of the paper.                                 | `DOSCAR`, `projdos.dat`, `plot_dos.py`                |
| `hse06/`                                                     | Input and output files of all single‑shot HSE06 runs (high cutoff) used for band gaps and dielectric constants.           | `INCAR`, `KPOINTS`, `EIGENVAL`, `OUTCAR`              |
| `phonons-xtb/`                                               | Phonopy inputs and force‑constant matrices derived from xTB forces (0 K).                                                 | `FORCE_SETS`, `phonopy.yaml`, `phonon_dispersion.dat` |
| `stress-tensor/`                                             | Finite‑strain stress–strain data from PBE‑relaxed cells (VASP).                                                           | `strain.dat`, `stress.dat`, `fit_elastic.py`          |
| `stress-tensor-xtb/`                                         | Same as above, but computed with xTB for comparison and speed.                                                             | `strain_xtb.dat`, `stress_xtb.dat`                    |

---

## Quick‑start guide

```bash
# Clone repository (≈ 20 MB)
git clone https://github.com/ac-dias/AsNCa3-paper-raw-data.git
cd AsNCa3-paper-raw-data

# Reproduce the PBE band structure
cd bands
python plot_bands.py  # requires numpy, matplotlib

# Generate phonon dispersion from provided force constants
cd ../phonons-xtb
phonopy -p phonopy.yaml  # interactive plot

# Compute optical absorption using WanTiBEXOS
cd ../TB-data
wantibexos run config.yaml  # see config file for options
```

*Software versions tested:* VASP 6.4, DFTB+ 22.1, xTB 6.5.1, Phonopy 2.23.0, WanTiBEXOS 0.4.  Results may differ slightly with future releases.

---

## Re‑running VASP calculations

The supplied `INCAR` files are tailored to our HPC settings:

* **ENCUT = 450 eV** for production DOS/bands; **800 eV** for all relaxations.
* **EDIFF = 1E-6 eV**, **EDIFFG = -0.01 eV/Å**.
* Γ‑centred Monkhorst–Pack meshes at **40 k‑points Å⁻¹** (structural) and **80 k‑points Å⁻¹** (DOS).
* HSE06 calculations use `HFSCREEN = 0.2` (standard) and the same k‑meshes as PBE.

> **Tip:** If memory is limited, reduce `ENCUT` to 600 eV for geometry optimisations—this changes lattice constants by <0.1 %.  The HSE06 input sets are less forgiving; see Section S4 of the SI for convergence tests.

---

## Citation

If you use this data in your work, please cite:

```
M. Irfan *et al.* "Towards High-Efficiency Solar Cells: Insights into \ce{AsNCa3} Antiperovskite as Active Layer", 2025, Journal TBA.
```

Additionally, cite the relevant software packages as specified in the paper and their individual manuals.
