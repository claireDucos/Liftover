rule liftover:
    input:
        vcf="vcf/{sample}.vcf.gz",
        chaine="genome/hg19ToHg38.over.chain.gz",
        fasta="genome/hg38.fa"
    output:
        vcf="results/{sample}.vcf",
        rej="reject/{sample}_rejected.vcf"
    message:
        "Liftover : {wildcards.sample}"
    threads:
        1
    resources:
        mem_mb = (
            lambda wildcards, attempt: min(attempt * 2048 + 2048, 8192)
        ),
        time_min = (
            lambda wildcards, attempt: min(attempt * 60, 120)
        )
    log:
        "logs/{sample}.vcf.log"

    shell:
         """picard -Xmx12G -Xms12G LiftoverVcf I={input.vcf} O={output.vcf} CHAIN={input.chaine} REJECT={output.rej} R={input.fasta} > {log} 2>&1"""






