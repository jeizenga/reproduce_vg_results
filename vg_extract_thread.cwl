#!/usr/env/bin cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: Extract a haplotype thread from a genome graph

hints:
  DockerRequirement:
    dockerPull: quay.io/vgteam/vg:dev-v1.12.1-51-g28ef4e32-t258-run
  SoftwareRequirement:
    packages:
      vg:
        version: ["1.12.1"]
        specs: [ https://doi.org/10.1038/nbt.4227 ]

inputs:
  indexed_genome_graph:
    type: File
    inputBinding:
      prefix: --xg-name
    format: vg:XG_Format

  thread_name:
    type: string
    inputBinding:
      prefix: --threads-named

baseCommand: [ vg, find ]

arguments:
  - --store-alignments
  - --show-progress

outputs:
  thread_graph: $(inputs.indexed_genome_graph.nameroot)_$(inputs.thread_name).xg
    format: vg:VG_Format


$namespaces:
  vg: http://biohackathon.org/resource/vg#
