#!/usr/env/bin cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: Reassign genome graph node IDs in topological order

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

baseCommand: [ vg, ids ]

arguments:
  - --sort

stdout: $(inputs.genome_graph.nameroot)_sorted.vg

outputs:
  id_sorted_genome_graph: stdout
    format: vg:VG_Format
  
$namespaces:
  vg: http://biohackathon.org/resource/vg#

