<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Player extends Model
{
    protected $table = 'players';

    //equipo del player
    use HasFactory;
    public function equipo(): BelongsTo
    {
        return $this->belongsTo(Team::class);
    }
}
