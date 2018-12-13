#!/usr/env/bin cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: Create indexes of a genome graph

hints:
  DockerRequirement:
    dockerPull: quay.io/vgteam/vg:dev-v1.12.1-51-g28ef4e32-t258-run
  SoftwareRequirement:
    packages:
      vg:
        version: ["1.12.1"]
        specs: [ https://doi.org/10.1038/nbt.4227 ]

inputs:
  genome_graph:
    type: File
    inputBinding:
      position: 1
    format: vg:VG_Format

  haplotypes:
    type: File? # optionally add haplotypes or not
    inputBinding:
      prefix: --vcf-phasing
    format: edam:format_3016  # VCF

baseCommand: [ vg, index ]

arguments:
  - --store-alignments
  - --show-progress

outputs:
  xg_index: $(inputs.genome_graph.nameroot).xg
    format: vg:XG_Format
  #gbwt: $(inputs.genome_graph.nameroot)_$(inputs.haplotypes.nameroot).gbwt
  #  format: vg:GBWT_Format


$namespaces:
  edam: http://edamontology.org/
  vg: http://biohackathon.org/resource/vg#
