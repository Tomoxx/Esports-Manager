<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TournamentTeam extends Model
{
    use HasFactory;
    protected $table = 'tournament_teams';
    public function team(): BelongsTo
    {
        return $this->belongsTo(Team::class);
    }
    public function tournament(): BelongsTo
    {
        return $this->belongsTo(Tournament::class);
    }
}
