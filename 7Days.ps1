# Chemin du répertoire cible
$repertoireCible = "C:\Users\rolli\Téléchargements"

# Chemin du dossier d'archive
$dossierArchive = Join-Path -Path $repertoireCible -ChildPath "archive"

# Créer le dossier d'archive s'il n'existe pas
if (-Not (Test-Path -Path $dossierArchive)) {
    New-Item -ItemType Directory -Path $dossierArchive
}

# Date limite (7 jours en arrière)
$dateLimit = (Get-Date).AddDays(-7)

# Parcourir les fichiers dans le répertoire cible
Get-ChildItem -Path $repertoireCible -File | ForEach-Object {
    if ($_.LastWriteTime -lt $dateLimit) {
        # Déplacer le fichier vers le dossier d'archive
        Move-Item -Path $_.FullName -Destination $dossierArchive
        Write-Output "Déplacé : $($_.Name)"
    }
}

Write-Output "Déplacement terminé."