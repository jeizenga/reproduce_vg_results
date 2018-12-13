#!/usr/env/bin cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: Construct a genome graph
doc: Includes both the reference sequences and alternative alleles

hints:
  DockerRequirement:
    dockerPull: quay.io/vgteam/vg:dev-v1.12.1-51-g28ef4e32-t258-run
  SoftwareRequirement:
    packages:
      vg:
        version: ["1.12.1"]
        specs: [ https://doi.org/10.1038/nbt.4227 ]
  ResourceRequirement:
    minCores: 8

inputs:
  reference_genome:
    type: File
    secondaryFiles:
     - .fai
    inputBinding:
      prefix: --reference
    format: edam:format_1929  # we need a IRI/URI for FASTA format

  genomic_variants:
    type: File
    secondaryFiles:
     - .tbi
    inputBinding:
      prefix: --vcf
    format: edam:format_3016  # VCF

baseCommand: [ vg, construct ]

arguments:
  - --show-progress
  - --alt-paths
  - prefix: --node-max
    valueFrom: "32"
  - prefix: --threads
    valueFrom: $(runtime.cores)

stdout: $(inputs.reference_genome.nameroot)_$(inputs.genomic_variants.nameroot).vg

outputs:
  genome_graph: stdout
    format: vg:VG_Format

$namespaces:
  edam: http://edamontology.org/
  vg: http://biohackathon.org/resource/vg#
